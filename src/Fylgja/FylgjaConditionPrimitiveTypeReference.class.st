Class {
	#name : #FylgjaConditionPrimitiveTypeReference,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionPrimitiveTypeReference >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ aProvenanceEntityRelation to isKindOf: MOPrimitiveTypeReference
]
