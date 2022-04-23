Class {
	#name : #FylgjaConditionInvocationSelectorIs,
	#superclass : #FylgjaCondition,
	#instVars : [
		'selector'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionInvocationSelectorIs class >> priority [

	^ 8
]

{ #category : #testing }
FylgjaConditionInvocationSelectorIs >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [

	^ aProvenanceEntityRelation to isInvocation and: [ aProvenanceEntityRelation to selector = selector ]
]

{ #category : #accessing }
FylgjaConditionInvocationSelectorIs >> selector: aString [ 
	selector := aString
]
