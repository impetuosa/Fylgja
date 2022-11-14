Class {
	#name : #FylgjaConditionOr,
	#superclass : #FylgjaCondition,
	#instVars : [
		'left',
		'right'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionOr >> left: aCondition [

	left := aCondition
]

{ #category : #testing }
FylgjaConditionOr >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ (left
		   matches: aProvenanceEntityRelation
		   context: aDestinationContextRelation
		   forWriting: aType
		   with: aWriter) or: [ 
		  right
			  matches: aProvenanceEntityRelation
			  context: aDestinationContextRelation
			  forWriting: aType
			  with: aWriter ]
]

{ #category : #testing }
FylgjaConditionOr >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [

	^ (left
		   matches: aDestinationEntity
		   context: aDestinationContextRelation
		   toBindAs: aCandidateRelation
		   consideringMappingsFrom: aLookup) or: [ 
		  right
			  matches: aDestinationEntity
			  context: aDestinationContextRelation
			  toBindAs: aCandidateRelation
			  consideringMappingsFrom: aLookup ]
]

{ #category : #accessing }
FylgjaConditionOr >> right: aCondition [

	right := aCondition
]
