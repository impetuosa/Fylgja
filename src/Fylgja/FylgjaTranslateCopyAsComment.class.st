Class {
	#name : #FylgjaTranslateCopyAsComment,
	#superclass : #FylgjaTranslation,
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsComment class >> possibleWritingMessages [

	^ { #writeComment: }
]

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

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsComment >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ self canWriteOver: aWriter
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsComment >> printOn: aStream [
 	aStream nextPutAll: 'Transform into Comment'
]
