Class {
	#name : #FylgjaConditionReferenceWithoutCandidate,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionReferenceWithoutCandidate class >> priority [ 
	^ 9
]

{ #category : #accessing }
FylgjaConditionReferenceWithoutCandidate >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation [

	^ aDestinationEntity allCandidateRelations allSatisfy: [ :a | 
		  a to isNil ]
]
