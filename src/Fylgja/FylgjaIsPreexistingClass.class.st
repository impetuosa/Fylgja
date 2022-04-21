Class {
	#name : #FylgjaIsPreexistingClass,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Test-VWPharo'
}

{ #category : #testing }
FylgjaIsPreexistingClass >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [
	^ (aProvenanceEntityRelation to isKindOf:MOStClass ) and:[ aProvenanceEntityRelation to isPreexisting  ]
]
