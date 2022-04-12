Class {
	#name : #FylgjaIsFFIPragma,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Test-VWPharo'
}

{ #category : #testing }
FylgjaIsFFIPragma >> matches: aProvenanceEntity context: aDestinationContext forWriting: aType [
  ^(aProvenanceEntity isKindOf: MOStPragma) and: [ aProvenanceEntity selector = #C: ]
]

{ #category : #testing }
FylgjaIsFFIPragma >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation [

	^ false 
]
