Class {
	#name : #FylgjaBindRewrite,
	#superclass : #FylgjaBinding,
	#instVars : [
		'destinationEntity'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaBindRewrite >> bind: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	| currentCandidate |
	self assert:
		(aDestinationEntity refersToObjectsLike: destinationEntity).
	self assert: aDestinationEntity name = destinationEntity name.
	currentCandidate := aCandidateRelation read: aDestinationEntity.
	self assert:
		(currentCandidate isNil or: [ currentCandidate isFylgjaStub ]).
	aCandidateRelation write: destinationEntity to: aDestinationEntity.
	^ aDestinationEntity
]

{ #category : #'as yet unclassified' }
FylgjaBindRewrite >> destinationEntity: aDestinationEntity [

	destinationEntity := aDestinationEntity
]
