Class {
	#name : #FylgjaConditionReferenceCandidateIs,
	#superclass : #FylgjaCondition,
	#instVars : [
		'candidate'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #'\\' }
FylgjaConditionReferenceCandidateIs >> candidate: aMOClassFunction [ 
	candidate := aMOClassFunction
]

{ #category : #testing }
FylgjaConditionReferenceCandidateIs >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [

	^ aProvenanceEntityRelation isReference and: [ 
		  aProvenanceEntityRelation to candidate = candidate ]
]

{ #category : #testing }
FylgjaConditionReferenceCandidateIs >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation [

	^ candidate = aCandidateRelation to
]
