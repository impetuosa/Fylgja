Class {
	#name : #FylgjaMatchingRuleTests,
	#superclass : #NotThatGoodTests,
	#category : #'Fylgja-Test'
}

{ #category : #initialization }
FylgjaMatchingRuleTests >> testAllConditionMatchesTheCase [

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
FylgjaMatchingRuleTests >> testDataSourceToErrorHandling [

	| debug destination |
	debug := self dataSourceConfigClassConfigPackage.
	destination := self errorHandlingClass.

	self should: [ fylgja get: debug for: destination ] raise: NotFound
]

{ #category : #initialization }
FylgjaMatchingRuleTests >> testEntityEqualsConditionMatchesTheCase [

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
FylgjaMatchingRuleTests >> testEntityIdenticalConditionMatchesTheCase [

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
FylgjaMatchingRuleTests >> testLogErrorToClassNoMappingExists [

	| debug destination |
	debug := self logErrorFunction.
	destination := self modelStubClass.

	self should: [ fylgja get: debug for: destination ] raise: NotFound
]

{ #category : #initialization }
FylgjaMatchingRuleTests >> testTypeConditionMatchesTheCase [

	| variable destinationContext |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.

	self assert:
		(fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) isEmpty.

	FylgjaRuleInstaller new
		context: destinationContext;
		whenTypeOfModelEntityIs: variable class;
		copy;
		installInto: fylgja.

	self assert:
		(fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) size equals: 1
]
