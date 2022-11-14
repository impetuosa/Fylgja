Class {
	#name : #FylgjaBindToLinkedStub,
	#superclass : #FylgjaBinding,
	#category : #'Fylgja-Rule-Binding'
}

{ #category : #'as yet unclassified' }
FylgjaBindToLinkedStub >> bind: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	| candidate |

	
	candidate := aDestinationWriter writeFylgjaCandidateStub: [ :a | 
		             a parent: aDestinationEntity.
		             a provenance: aCandidateRelation.
		             a referee: aCandidateRelation to ].
	aCandidateRelation write: candidate to: aDestinationEntity.
	^ aDestinationEntity
]
