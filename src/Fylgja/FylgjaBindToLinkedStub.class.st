Class {
	#name : #FylgjaBindToLinkedStub,
	#superclass : #FylgjaBindingPredicate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaBindToLinkedStub >> bind: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	| candidate |

	
	candidate := aDestinationWriter writeFylgjaCandidateStub: [ :a | 
		             a parent: aDestinationEntity.
		             a provenance: aCandidateRelation.
		             a candidate: aCandidateRelation to ].
	aCandidateRelation write: candidate to: aDestinationEntity.
	^ aDestinationEntity
]
