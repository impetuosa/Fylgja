Class {
	#name : #FylgjaConditionModelTypeIsAndNamed,
	#superclass : #FylgjaConditionModelTypeIs,
	#instVars : [
		'names'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionModelTypeIsAndNamed >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ (super
		   matches: aProvenanceEntityRelation
		   context: aDestinationContextRelation
		   forWriting: aType
		   with: aWriter) and: [ 
		  names includes: aProvenanceEntityRelation to name ]
]

{ #category : #testing }
FylgjaConditionModelTypeIsAndNamed >> names: aCollection [ 
	names := aCollection
]
