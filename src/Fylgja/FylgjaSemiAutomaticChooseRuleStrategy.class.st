Class {
	#name : #FylgjaSemiAutomaticChooseRuleStrategy,
	#superclass : #FylgjaChooseRuleStrategy,
	#category : #'Fylgja-MRS'
}

{ #category : #'as yet unclassified' }
FylgjaSemiAutomaticChooseRuleStrategy >> chooseRule: aCollection [

	| simpleListOfSources |
	simpleListOfSources := self filterOneRulePerMaxPriorityPerSource:
		                       aCollection.

	"make up a dialog able to choose a single rule ."
]
