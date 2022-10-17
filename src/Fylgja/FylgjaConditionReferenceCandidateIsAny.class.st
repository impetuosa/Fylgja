Class {
	#name : #FylgjaConditionReferenceCandidateIsAny,
	#superclass : #FylgjaCondition,
	#instVars : [
		'candidates'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionReferenceCandidateIsAny >> candidates: anArray [  
	candidates := anArray 
]

{ #category : #accessing }
FylgjaConditionReferenceCandidateIsAny >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ candidates anySatisfy: [ :c | 
		  aProvenanceEntityRelation isReference and: [ 
			  aProvenanceEntityRelation to candidate = c ] ]
]

{ #category : #accessing }
FylgjaConditionReferenceCandidateIsAny >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [

	^ candidates includes: aCandidateRelation to
]

{ #category : #accessing }
FylgjaConditionReferenceCandidateIsAny >> printOn: aStream [

	aStream
		nextPutAll: 'IsReference With Candidate ';
		nextPutAll: ('|' join: (candidates collect: #name))
]
