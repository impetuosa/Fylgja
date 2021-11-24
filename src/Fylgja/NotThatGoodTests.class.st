Class {
	#name : #NotThatGoodTests,
	#superclass : #TestCase,
	#instVars : [
		'fylgja',
		'angular',
		'java',
		'northwind'
	],
	#category : #'Fylgja-Test'
}

{ #category : #initialization }
NotThatGoodTests >> angularClassStudent [

	^ ((angular packages detect: [ :p | p name = 'app' ]) types detect: [ : a | a isKindOf: MOAngularClass  ]) classRepresentation
]

{ #category : #initialization }
NotThatGoodTests >> angularPackage [

	^ angular packages detect: [ :p | p name = 'app' ]
]

{ #category : #initialization }
NotThatGoodTests >> configClassConfigPackage [

	^ self configPackage types detect: [ :t | t name = 'Config' ]
]

{ #category : #initialization }
NotThatGoodTests >> configDataSource [ 
	java entities 
]

{ #category : #initialization }
NotThatGoodTests >> configPackage [

	^ java packages detect: [ :p | p name = 'config' ]
]

{ #category : #initialization }
NotThatGoodTests >> dataSourceConfigClassConfigPackage [

	^ self configClassConfigPackage methods detect: [ :i | 
		  i selector = 'dataSource' ]
]

{ #category : #initialization }
NotThatGoodTests >> errorHandlingClass [

	^ northwind detect: [ :a | 
		  (a isKindOf: AlcixClass) and: [ a name = 'ErrorHandling' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> logErrorFunction [

	^ northwind detect: [ :a | 
		  (a isKindOf: AlcixInvocable) and: [ 
			  a name = 'LogError' and: [ a userType isNotNil ] ] ]
]

{ #category : #initialization }
NotThatGoodTests >> modelPackage [

	^ java packages detect: [ :p | p name = 'Model' ]
]

{ #category : #initialization }
NotThatGoodTests >> modelStubClass [

	^ (java packages detect: [ :p | p name = 'Model' ]) types detect: [ 
		  :t | t name = 'Stub' ]
]

{ #category : #initialization }
NotThatGoodTests >> setUp [

	super setUp.

	fylgja := FylgjaModel new.

	northwind := MooseModelRoot root entities first.
	angular := MOAngularLoader new
		           workingDirectory:
			           '/Users/sbragagn/git/northwind-angular' asFileReference;
		           loadNamed: #angular.

	java := MOJavaMooseBasedLoader new
		        workingDirectory:
			        '/Users/sbragagn/git/jnorthwind/jnorthwind';
		        mooseModel: MooseModelRoot root entities second;
		        loadNamed: #java.
 
	fylgja
		addModel: northwind;
		addModel: angular;
		addModel: java
]

{ #category : #initialization }
NotThatGoodTests >> testDataSourceToErrorHandling [

	| debug destination |
	debug := self dataSourceConfigClassConfigPackage.
	destination := self errorHandlingClass.

	self should: [ fylgja get: debug for: destination ] raise: NotFound
]

{ #category : #initialization }
NotThatGoodTests >> testLogErrorToClassNoMappingExists [

	| debug destination |
	debug := self logErrorFunction.
	destination := self modelStubClass.

	self should: [ fylgja get: debug for: destination ] raise: NotFound
]

{ #category : #initialization }
NotThatGoodTests >> testMapToRewriteRule [

	| debug destination |
	debug := self logErrorFunction . 
	destination := self modelStubClass.

	self assert: destination methods isEmpty.

	FylgjaTranslateBuilder new
		fylgja: fylgja;
		translate: debug;
		into: destination;
		build;
		install.
	
	 self should: [fylgja getOrProduce: debug for: destination] raise: FylgjaMapWarning 
	
]

{ #category : #initialization }
NotThatGoodTests >> testMapToRewriteRuleErrorHandling [

	| debug destination |
	debug := self errorHandlingClass.
	destination := self modelPackage.


	FylgjaTranslateBuilder new
		fylgja: fylgja;
		translate: debug;
		into: destination;
		build;
		install.

	self
		should: [ fylgja getOrProduce: debug for: destination ]
		raise: FylgjaMapWarning
]

{ #category : #initialization }
NotThatGoodTests >> testMapToRewriteRuleErrorHandlingText [

	| debug destination |
	debug := self errorHandlingClass.
	destination := self modelPackage.


	FylgjaTranslateBuilder new
		fylgja: fylgja;
		translate: debug;
		into: destination;
		build;
		install.

	fylgja getOrProduce: debug for: destination.

	destination types last produceCode inspect
]

{ #category : #initialization }
NotThatGoodTests >> testMapToRewriteRuleTextAccessDatasourceErrorExpected [

	| debug destination result parser hadError code |
	debug := self dataSourceConfigClassConfigPackage.
	destination := self errorHandlingClass.
	hadError := false.

	FylgjaTranslateBuilder new
		fylgja: fylgja;
		translate: debug;
		into: destination;
		build;
		install.

	result := [ fylgja getOrProduce: debug for: destination ]
		          on: FylgjaMapWarning
		          do: [ :e | e resume ].

	code := result parent produceCode.

	parser := VBParser
		          createParserOnStream: code readStream
		          startingAt: JavaParser defaultStartingState.
	code inspect.
	parser parse inspect.

	self deny: hadError
]

{ #category : #initialization }
NotThatGoodTests >> testMapToRewriteRuleTextJavaErrorExpected [

	| debug destination result parser hadError code |
	debug := self logErrorFunction.
	destination := self modelStubClass.
	hadError := false.
	self assert: destination methods isEmpty.

	FylgjaTranslateBuilder new
		fylgja: fylgja;
		translate: debug;
		into: destination;
		build;
		install.

	result :=[ fylgja getOrProduce: debug for: destination.] on: FylgjaMapWarning do: [  :e | e resume  ].
	
	code :=  destination produceCode .
	
	parser := JavaParser
		          createParserOnStream: code readStream
		          startingAt: JavaParser defaultStartingState.
	
	[ parser parse ]
		on: SmaCCParserError
		do: [ :e | 
			hadError := true.
			self assert: parser currentToken value = '""' ].

	self assert: hadError
]

{ #category : #initialization }
NotThatGoodTests >> testMapToRewriteRuleTextJavaRunsAfterModifyingOperator [

	| debug destination result parser  code |
	debug := self logErrorFunction.
	destination := self modelStubClass.

	self assert: destination methods isEmpty.

	FylgjaTranslateBuilder new
		fylgja: fylgja;
		translate: debug;
		into: destination;
		build;
		install.

	result :=[ fylgja getOrProduce: debug for: destination.] on: FylgjaMapWarning do: [  :e | e resume  ].
	
	code :=  destination produceCode .
	code := code copyReplaceAll: '<>' with: '!='.
	parser := JavaParser
		          createParserOnStream: code readStream
		          startingAt: JavaParser defaultStartingState.
	
	self assert: (parser parse isKindOf: JavaProgramFileNode).

]

{ #category : #initialization }
NotThatGoodTests >> testMapToRewriteRuleTextTSRunsAfterModifyingOperator [

	| debug destination result parser  code |
	debug := self logErrorFunction.
	destination := self angularClassStudent.

	self assert: destination methods isEmpty.

	FylgjaTranslateBuilder new
		fylgja: fylgja;
		translate: debug;
		into: destination;
		build;
		install.

	result :=[ fylgja getOrProduce: debug for: destination.] on: FylgjaMapWarning do: [  :e | e resume  ].
	
	code :=  destination produceCode .
	code := code copyReplaceAll: '<>' with: '!='.
	parser := TypeScriptParser 
		          createParserOnStream: code readStream
		          startingAt: JavaParser defaultStartingState.
	
	self assert: (parser parse isKindOf: JSModuleNode).

]

{ #category : #initialization }
NotThatGoodTests >> testMapToRewriteRuleTextTypeScript [

	| debug destination result parser hadError |
	debug := self logErrorFunction.
	destination := self angularClassStudent.
	hadError := false.
	self assert: destination methods isEmpty.

	FylgjaTranslateBuilder new
		fylgja: fylgja;
		translate: debug;
		into: destination;
		build;
		install.

	result := [ fylgja getOrProduce: debug for: destination ]
		          on: FylgjaMapWarning
		          do: [ :e | e resume ].


	parser := TypeScriptParser
		          createParserOnStream: destination produceCode readStream
		          startingAt: JavaParser defaultStartingState.


	[ parser parse ]
		on: SmaCCParserError
		do: [ :e | 
			hadError := true.
			self assert: parser currentToken value = '>' ].

	self assert: hadError
]

{ #category : #initialization }
NotThatGoodTests >> testMapToRewriteRuleTextTypeScriptErrorExpected [

	| debug destination result parser hadError |
	debug := self logErrorFunction.
	destination := self angularClassStudent.
	hadError := false.
	self assert: destination methods isEmpty.

	FylgjaTranslateBuilder new
		fylgja: fylgja;
		translate: debug;
		into: destination;
		build;
		install.

	result :=[ fylgja getOrProduce: debug for: destination.] on: FylgjaMapWarning do: [  :e | e resume  ].
	
	
	parser := TypeScriptParser
		          createParserOnStream: destination produceCode readStream
		          startingAt: JavaParser defaultStartingState.


	[ parser parse ]
		on: SmaCCParserError
		do: [ :e | 
			hadError := true.
			self assert: parser currentToken value = '>' ].

	self assert: hadError
]

{ #category : #initialization }
NotThatGoodTests >> testTranslateLogErrorBuildAndInstall [

	| debug destination |
	debug := self logErrorFunction.
	destination := self modelStubClass.

	self assert: destination methods isEmpty.

	FylgjaTranslateBuilder new
		fylgja: fylgja;
		translate: debug;
		into: destination;
		build;
		install.

	self assert: fylgja producers isNotEmpty
]
