Class {
	#name : #FylgjaMigrationPredicate,
	#superclass : #FylgjaOperation,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaMigrationPredicate >> applyBindTo: aDestinationEntity withCandidateFrom: aProvenanceEntity croppingRelationsWith: aBlock writer: writer lookup: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| candidateRelations |
	candidateRelations := aProvenanceEntity to allCandidateRelations.

	self assert: candidateRelations size = 1.


	^ aFylgjaDerivativeModel
		  bindAndReturnEntity: aDestinationEntity
		  as: candidateRelations first
		  croppingRelationsWith: aBlock
		  usingWriter: writer
		  lookUp: aFylgjaLookUpContext
]

{ #category : #'as yet unclassified' }
FylgjaMigrationPredicate >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	self subclassResponsibility
]
