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
  ^(aProvenanceEntityRelation to isKindOf: MOMethod) and: [ names includes: aProvenanceEntityRelation to selector ]
]

{ #category : #accessing }
FylgjaConditionAnyMethodNamed >> names: aCollection [ 
	names := aCollection
]
