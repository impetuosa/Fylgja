Class {
	#name : #FylgjaConditionReferenceWithCandidate,
	#superclass : #FylgjaCondition,
	#instVars : [
		'elements'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionReferenceWithCandidate class >> priority [ 
	^ 9
]

{ #category : #accessing }
FylgjaConditionReferenceWithCandidate >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation [

	^ (aDestinationEntity allCandidateRelations select: [ :a | 
		   a to isNil ]) isEmpty
]
