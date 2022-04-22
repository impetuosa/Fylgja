Class {
	#name : #FylgjaProduction,
	#superclass : #FylgjaOperation,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaProduction >> applyBindTo: aDestinationEntity withCandidateFrom: aProvenanceEntity croppingRelationsWith: aBlock writer: writer lookup: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| candidateRelations |
	candidateRelations := aProvenanceEntity to allCandidateRelations.

	self assert: candidateRelations size = 1.


	^ aFylgjaDerivativeModel
		  mapEntity: aDestinationEntity
		  as: candidateRelations first
		  croppingRelationsWith: aBlock
		  usingWriter: writer
		  lookUp: aFylgjaLookUpContext
]

{ #category : #'as yet unclassified' }
FylgjaProduction >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

  ^aDestinationWriter writeComment: [:comment |  
		FylgjaTranslateCopy new 
					applyTo: aRelatedProvenanceEntity 
					croppingRelationsWith: aBlock 
					destinationWriter: comment 
					lookUp: aFylgjaLookUpContext 
					using: aFylgja 
		]
]
