Class {
	#name : #FylgjaPreexistingClass,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Test-VWPharo'
}

{ #category : #testing }
FylgjaPreexistingClass >> matches: aProvenanceEntity context: aDestinationContext forWriting: aType [
  ^(aProvenanceEntity isKindOf: MOStClass) and: [ aProvenanceEntity isPreexisting ]
]
