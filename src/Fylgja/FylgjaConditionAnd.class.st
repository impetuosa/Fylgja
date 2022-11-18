Class {
	#name : #FylgjaConditionAnd,
	#superclass : #FylgjaCondition,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionAnd >> left: aCondition [

	left := aCondition
]

{ #category : #testing }
FylgjaConditionAnd >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ (left
		   matches: aProvenanceEntityRelation
		   context: aDestinationContextRelation
		   forWriting: aType
		   with: aWriter) and: [ 
		  right
			  matches: aProvenanceEntityRelation
			  context: aDestinationContextRelation
			  forWriting: aType
			  with: aWriter ]
]

{ #category : #testing }
FylgjaConditionAnd >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [

	^ (left
		   matches: aDestinationEntity
		   context: aDestinationContextRelation
		   toBindAs: aCandidateRelation
		   consideringMappingsFrom: aLookup) and: [ 
		  right
			  matches: aDestinationEntity
			  context: aDestinationContextRelation
			  toBindAs: aCandidateRelation
			  consideringMappingsFrom: aLookup ]
]

{ #category : #accessing }
FylgjaConditionAnd >> right: aCondition [

	right := aCondition
]
