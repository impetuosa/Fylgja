Class {
	#name : #FylgjaConditionReferenceWithCandidate,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionReferenceWithCandidate class >> priority [ 
	^ 9
]

{ #category : #accessing }
FylgjaConditionReferenceWithCandidate >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [

	| candidates |
	candidates := aDestinationEntity allCandidateRelations.
	^ candidates isNotEmpty and: [ 
		  candidates noneSatisfy: [ :a | a to isNil ] ]
]
