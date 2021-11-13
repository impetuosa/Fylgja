Class {
	#name : #NotThatGoodTests,
	#superclass : #TestCase,
	#instVars : [
		'fylgja',
		'angular',
		'java'
	],
	#category : #'Fylgja-Test'
}

{ #category : #initialization }
NotThatGoodTests >> logErrorFunction [

	^ fylgja origin detect: [ :a | 
		  (a isKindOf: AlcixInvocable) and: [ a name = 'LogError' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> modelStubClass [

	^ (java packages detect: [ :p | p name = 'Model' ]) types detect: [ 
		  :t | t name = 'Stub' ]
]

{ #category : #initialization }
NotThatGoodTests >> setUp [

	super setUp.

	fylgja := FylgjaModel new
		          mooseModel: MooseModelRoot root entities first;
		          yourself.

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
		addDestination: angular;
		addDestination: java
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
	
	fylgja getOrProduce: debug for: destination
	
]

{ #category : #initialization }
NotThatGoodTests >> testMapToRewriteRuleText [

	| debug destination result parser hadError |
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

	result := fylgja getOrProduce: debug for: destination.

	parser := TypeScriptParser
		          createParserOnStream: destination produceCode readStream
		          startingAt: TypeScriptParser defaultStartingState.
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
