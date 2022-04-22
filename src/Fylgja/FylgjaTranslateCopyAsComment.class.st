Class {
	#name : #FylgjaTranslateCopyAsComment,
	#superclass : #FylgjaTranslation,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsComment >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

  ^aDestinationWriter writeComment: [:comment |  
		FylgjaTranslateCopy new 
					applyTo: aRelatedProvenanceEntity 
					croppingRelationsWith: aBlock 
					destinationWriter: comment 
					lookUp: aFylgjaLookUpContext 
					using: aFylgja 
		]
]
