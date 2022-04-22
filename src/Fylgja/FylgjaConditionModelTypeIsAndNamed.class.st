Class {
	#name : #FylgjaConditionModelTypeIsAndNamed,
	#superclass : #FylgjaConditionModelTypeIs,
	#instVars : [
		'names'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionModelTypeIsAndNamed >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [
  ^(super matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType) and: [ names includes: aProvenanceEntityRelation to name ]
]

{ #category : #testing }
FylgjaConditionModelTypeIsAndNamed >> names: aCollection [ 
	names := aCollection
]
