Class {
	#name : #FylgjaIsFFIPragma,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Test-VWPharo'
}

{ #category : #testing }
FylgjaIsFFIPragma >> matches: aProvenanceEntity context: aDestinationContext forWriting: aType with: aWriter [
  ^(aProvenanceEntity isKindOf: MOStPragma) and: [ aProvenanceEntity selector literal = #C: ]
]

{ #category : #testing }
FylgjaIsFFIPragma >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [

	^ false 
]
