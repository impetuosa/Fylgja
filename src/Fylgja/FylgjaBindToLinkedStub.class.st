Class {
	#name : #FylgjaBindToLinkedStub,
	#superclass : #FylgjaBinding,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaBindToLinkedStub >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	"	produced := self
		            writeCopyOf: aProvenanceEntityRelation
		            croppingRelationsWith: aBlock
		            destinationWriter: aDestinationWriter
		            lookUp: aFylgjaLookUpContext
		            using: aFylgjaDerivativeModel.
	^ produced"

	^ aDestinationWriter writeFylgjaCandidateStub: [ :a | 
		  a provenance: aProvenanceEntityRelation.
		  a candidate: aProvenanceEntityRelation to candidate ]
]
