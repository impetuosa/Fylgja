Class {
	#name : #FylgjaConditionAll,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionAll >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [


	^ true
]

{ #category : #testing }
FylgjaConditionAll >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [

	^ true
]

{ #category : #testing }
FylgjaConditionAll >> printOn: aStream [ 
	aStream nextPutAll: 'AllwaysTrue'
]
