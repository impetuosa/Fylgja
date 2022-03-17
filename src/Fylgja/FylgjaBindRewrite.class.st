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

	| produced |

	self assert:
		(aDestinationEntity refersToObjectsLike: destinationEntity).
	self assert: aDestinationEntity name = destinationEntity name.
	self assert: (aCandidateRelation read: aDestinationEntity) isNil.
	aCandidateRelation write: destinationEntity to: aDestinationEntity.
	^ aDestinationEntity
]

{ #category : #'as yet unclassified' }
FylgjaBindRewrite >> destinationEntity: aDestinationEntity [

	destinationEntity := aDestinationEntity
]
