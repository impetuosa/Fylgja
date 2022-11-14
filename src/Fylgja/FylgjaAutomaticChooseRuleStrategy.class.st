Class {
	#name : #FylgjaAutomaticChooseRuleStrategy,
	#superclass : #FylgjaChooseRuleStrategy,
	#category : #'Fylgja-MRS'
}

{ #category : #'as yet unclassified' }
FylgjaAutomaticChooseRuleStrategy >> chooseBindingRule: aCollection [

	| simpleListOfSources |
	simpleListOfSources := self filterOneRulePerMaxPriorityPerSource:
		                       aCollection.
	^ simpleListOfSources
		  ifEmpty: [ {  } ]
		  ifNotEmpty: [ "Returns a list of a single result. The first one. " 
			  { simpleListOfSources first } ]
]

{ #category : #'as yet unclassified' }
FylgjaAutomaticChooseRuleStrategy >> chooseRule: aCollection [

	| simpleListOfSources |
	simpleListOfSources := self filterOneRulePerMaxPriorityPerSource:
		                       aCollection.

	"Returns a list of a single result. The first one. "
	^ { simpleListOfSources first }
]
