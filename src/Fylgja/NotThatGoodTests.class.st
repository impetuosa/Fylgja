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

	northwind := MooseModelRoot root entities first.
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
	self halt
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

	| variable destinationContext |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.

	self assert:
		(fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) isEmpty.

	FylgjaRuleInstaller new
		context: destinationContext;
		matchesPattern: (FylgjaPatternBuilder new
				 parse: ' dim $ as String '
				 parser: VBParser
				 reader: MOAlceModelReader;
				 build);
		copy;
		installInto: fylgja.

	self assert:
		(fylgja
			 lookupRulesForProducing: variable
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
