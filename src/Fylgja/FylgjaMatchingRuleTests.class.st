Class {
	#name : #FylgjaMatchingRuleTests,
	#superclass : #NotThatGoodTests,
	#instVars : [
		'derivative'
	],
	#category : #'Fylgja-Test'
}

{ #category : #initialization }
FylgjaMatchingRuleTests >> derivative [

	^ derivative ifNil: [ derivative := fylgja derivative ]
]

{ #category : #initialization }
FylgjaMatchingRuleTests >> testAllConditionMatchesTheCase [

	| variable destinationContextRelation destinationContext |
	variable := self derivative readEntitysContextualizingRelation:
		            self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.
	destinationContextRelation := self derivative 
		                              readEntitysContextualizingRelation:
		                              destinationContext.


	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContextRelation
			 destinationModel:
			 (fylgja selectDerivativeModelFor: destinationContext)) isEmpty.

	FylgjaRuleInstaller new
		context: destinationContext;
		anyEntity;
		copy;
		installInto: fylgja.

	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContextRelation
			 destinationModel:
			 (fylgja selectDerivativeModelFor: destinationContext)) size = 1
]

{ #category : #initialization }
FylgjaMatchingRuleTests >> testTypeConditionMatchesTheCase [

	| variable destinationContextRelation destinationContext |
	variable := self derivative readEntitysContextualizingRelation:
		            self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.
	destinationContextRelation := self derivative 
		                              readEntitysContextualizingRelation:
		                              destinationContext.


	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContextRelation
			 destinationModel:
			 (fylgja selectDerivativeModelFor: destinationContext)) isEmpty.

	FylgjaRuleInstaller new
		context: destinationContext;
		whenTypeOfModelEntityIs: variable to class;
		copy;
		installInto: fylgja.

	self
		assert: (fylgja
				 lookupRulesForProducing: variable
				 toContext: destinationContextRelation
				 destinationModel:
				 (fylgja selectDerivativeModelFor: destinationContext)) size
		equals: 1
]
