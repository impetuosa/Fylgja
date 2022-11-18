Class {
	#name : #FylgjaConditionReferenceCandidateIs,
	#superclass : #FylgjaCondition,
	#instVars : [
		'candidate'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionReferenceCandidateIs >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ aProvenanceEntityRelation isReference and: [ 
		  aProvenanceEntityRelation to referee = candidate ]
]

{ #category : #testing }
FylgjaConditionReferenceCandidateIs >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [

	^ candidate isSameEntity: aCandidateRelation to
]

{ #category : #testing }
FylgjaConditionReferenceCandidateIs >> printOn: aStream [
 	aStream nextPutAll:'IsReference With Candidate '; nextPutAll: candidate name 
]

{ #category : #accessing }
FylgjaConditionReferenceCandidateIs >> referee [
	^ candidate
]

{ #category : #'\\' }
FylgjaConditionReferenceCandidateIs >> referee: aMOClassFunction [ 
	candidate := aMOClassFunction
]
