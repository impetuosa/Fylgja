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

{ #category : #'as yet unclassified' }
NotThatGoodTests >> blockDataSourceConfigClassConfigPackage [

	^ self dataSourceConfigClassConfigPackage block
]

{ #category : #initialization }
NotThatGoodTests >> configClassConfigPackage [

	^ self configPackage types detect: [ :t | t name = 'Config' ]
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

	^ northwind entities detect: [ :a | 
		  (a isKindOf: JinDAMClass) and: [ a name = 'ErrorHandling' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> logErrorFunction [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: JinDAMInvocable) and: [ 
			  a name = 'LogError' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> logErrorFunctionVariable [

	^ self logErrorFunction localVariables second
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
NotThatGoodTests >> runCaseManaged [ 
	^ self runCase 
]

{ #category : #initialization }
NotThatGoodTests >> setUp [

	super setUp.

	fylgja := FylgjaModel new.
	northwind := JinDAMModel northwind.
	angular := MOAngularLoader northwind.
	java := MOJavaMavenProjectLoader northwind.


	fylgja
		addModel: northwind;
		addModel: angular;
		addModel: java
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> statementDataSourceConfigClassConfigPackage [

	^ self dataSourceConfigClassConfigPackage block statements first
]

{ #category : #initialization }
NotThatGoodTests >> testAllConditionMatchesTheCase [

	| variable destinationContext |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.

	self assert:
		(fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) isEmpty.
			
	FylgjaRuleInstaller new
		context: destinationContext;
		anyEntity;
		copy;
		installInto: fylgja.

	self assert:
		(fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) size = 1
]

{ #category : #initialization }
NotThatGoodTests >> testDataSourceToErrorHandling [

	| debug destination |
	debug := self dataSourceConfigClassConfigPackage.
	destination := self errorHandlingClass.

	self should: [ fylgja get: debug for: destination ] raise: NotFound
]

{ #category : #initialization }
NotThatGoodTests >> testEntityEqualsConditionMatchesTheCase [

	| variable destinationContext |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.

	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) isEmpty.

	FylgjaRuleInstaller new
		context: destinationContext;
		whenEntityIs: variable;
		copy;
		installInto: fylgja.

	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) size = 1
]

{ #category : #initialization }
NotThatGoodTests >> testEntityIdenticalConditionMatchesTheCase [

	| variable destinationContext |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.

	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) isEmpty.

	FylgjaRuleInstaller new
		context: destinationContext;
		whenEntityIsIdenticalTo: variable;
		copy;
		installInto: fylgja.

	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) size = 1
]

{ #category : #initialization }
NotThatGoodTests >> testLogErrorToClassNoMappingExists [

	| debug destination |
	debug := self logErrorFunction.
	destination := self modelStubClass.

	self should: [ fylgja get: debug for: destination ] raise: NotFound
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> testProduceMethodIntoClassByCopyNodeTransformDefault [

	| variable destinationContext result |
	variable := self logErrorFunction.
	destinationContext := self configClassConfigPackage.

	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.

	" By default when going to java "
	FylgjaRuleInstaller new
		context: (fylgja selectDestinationModelFor: destinationContext );
		anyEntityOfTypes: { 
				MOFunction.
				MOProcedure };
		copyAsMethod;
		installInto: fylgja.


	result := fylgja produce: variable into: destinationContext.
	self halt 
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> testProduceMethodIntoClassByCopyNodeTransformDefaultFailsForMessageNotUnderstood [

	| variable destinationContext result |
	variable := self logErrorFunction.
	destinationContext := self configClassConfigPackage.


	FylgjaRuleInstaller new
		context: destinationContext;
		anyEntity;
		copy;
		installInto: fylgja.

	self
		should: [ 
		result := fylgja produce: variable into: destinationContext ]
		raise: MessageNotUnderstood
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> testProduceVariableIntoMethodByCopyNodeTransformDefault [

	| variable destinationContext result |
	variable := self logErrorFunctionVariable.
	destinationContext := self blockDataSourceConfigClassConfigPackage.

	FylgjaRuleInstaller new
		context: destinationContext;
		anyEntity;
		copy;
		installInto: fylgja.

	result := fylgja produce: variable into: destinationContext.
	self assert: (result result isKindOf: MOBlock).
	self assert: result result language isJava.
	self
		assert: result result statements size
		equals: destinationContext statements size + 1.
	1 to: destinationContext statements size do: [ :i | 
		self assert: (result result statements at: i)
			== (destinationContext statements at: i) ].
	self assert: result result statements last name = variable name.
	self assert: result result statements last language isJava.
	self assert:
		result result statements last typeReference name
		= variable type name.

]

{ #category : #initialization }
NotThatGoodTests >> testProduceVariableIntoMethodByCopyNodeTransformDefaultNoProducerFails [

	| variable destinationContext result |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.

	self
		should: [ 
		result := fylgja produce: variable into: destinationContext ]
		raise: NotFound
]

{ #category : #initialization }
NotThatGoodTests >> testRespondsToPatternConditionMatchesTheCase [

	| variable destinationContext moVariable |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.
	moVariable := (fylgja derivative readerFor: variable) read: variable.

	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) isEmpty.

	FylgjaRuleInstaller new
		context: destinationContext;
		matchesPattern: (FylgjaPatternBuilder new
				 parse: ' dim $ as String ';
				 parser: VBParser;
				 reader: MOAlceModelReader;
				 model: MOModel newMicrosoftAccess;
				 build);
		copy;
		installInto: fylgja.

	self assert: (fylgja
			 lookupRulesForProducing: moVariable
			 toContext: destinationContext) size = 1
]

{ #category : #initialization }
NotThatGoodTests >> testTypeConditionMatchesTheCase [

	| variable destinationContext |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.

	self assert:
		(fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) isEmpty.

	FylgjaRuleInstaller new
		context: destinationContext;
		whenType: variable class;
		copy;
		installInto: fylgja.

	self assert:
		(fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) size = 1
]
