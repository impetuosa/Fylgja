Class {
	#name : #FylgjaConditionInvocationSelectorIsInReturn,
	#superclass : #FylgjaCondition,
	#instVars : [
		'selector'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionInvocationSelectorIsInReturn >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [
  ^ (aProvenanceEntityRelation to isKindOf: MOReturn) 
		and: [ aProvenanceEntityRelation to expression isInvocation 
		and: [ aProvenanceEntityRelation to expression selector = selector ] 
	]
]

{ #category : #testing }
FylgjaConditionInvocationSelectorIsInReturn >> selector: aString [ 
	selector := aString
]
