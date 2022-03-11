Class {
	#name : #FylgjaMapToLinkedtStub,
	#superclass : #FylgjaMap,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaMapToLinkedtStub >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| produced |
	self assert:
		(aProvenanceEntityRelation to isKindOf: MOTypedReference).

	produced := self
		            writeCopyOf: aProvenanceEntityRelation
		            croppingRelationsWith: aBlock
		            destinationWriter: aDestinationWriter
		            lookUp: aFylgjaLookUpContext
		            using: aFylgjaDerivativeModel.
	produced candidate:
		(aDestinationWriter writeFylgjaCandidateStub: [ :a | 
			 a originalCandidate: aProvenanceEntityRelation to candidate ]).
	^ produced
]
