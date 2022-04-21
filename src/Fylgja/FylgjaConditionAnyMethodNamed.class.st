Class {
	#name : #FylgjaConditionAnyMethodNamed,
	#superclass : #FylgjaCondition,
	#instVars : [
		'names'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionAnyMethodNamed >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [
self halt 
]

{ #category : #accessing }
FylgjaConditionAnyMethodNamed >> names: aCollection [ 
	names := aCollection
]
