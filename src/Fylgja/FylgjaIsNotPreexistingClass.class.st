Class {
	#name : #FylgjaIsNotPreexistingClass,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Test-VWPharo'
}

{ #category : #testing }
FylgjaIsNotPreexistingClass >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [
	^ (aProvenanceEntityRelation to isKindOf:MOStClass ) and:[ aProvenanceEntityRelation to isPreexisting not ]
]
