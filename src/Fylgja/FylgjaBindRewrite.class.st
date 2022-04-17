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
	currentCandidate := aCandidateRelation read: aDestinationEntity.
	^ self rewriter
		  bind: aDestinationEntity
		  to: destinationEntity
		  semanticallyEquivalentTo: aCandidateRelation
		  destinationWriter: aDestinationWriter
		  lookUp: aFylgjaLookUpContext
		  using: aFylgja
]

{ #category : #'as yet unclassified' }
FylgjaBindRewrite >> destinationEntity: aDestinationEntity [

	destinationEntity := aDestinationEntity
]

{ #category : #accessing }
FylgjaBindRewrite >> rewriter [
	^  FylgjaBindNameBasedRewriter new .
]
