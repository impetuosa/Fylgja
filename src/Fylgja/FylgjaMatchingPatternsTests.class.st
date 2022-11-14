Class {
	#name : #FylgjaMatchingPatternsTests,
	#superclass : #NotThatGoodTests,
	#category : #'Fylgja-Test'
}

{ #category : #initialization }
FylgjaMatchingPatternsTests >> testRespondsToPatternConditionMatchesTheCase [

	| variable destinationContext moVariable |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.
	moVariable := (fylgja derivative readerFor: variable) read: variable.

	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext
			 destinationModel:
			 (fylgja selectDerivativeModelFor: destinationContext)) isEmpty.

	FylgjaRuleInstaller new
		context: destinationContext;
		matchesPattern: (FylgjaPatternBuilder new
				 parse: ' dim $ as String ';
				 parser: VBParser;
				 reader: MOJinDAMModelReader;
				 model: MOModel newMicrosoftAccess;
				 build);
		copy;
		installInto: fylgja.

	self
		assert: (fylgja
				 lookupRulesForProducing: moVariable
				 toContext: destinationContext
				 destinationModel:
				 (fylgja selectDerivativeModelFor: destinationContext)) size
		equals: 1
]
