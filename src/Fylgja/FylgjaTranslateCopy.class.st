Class {
	#name : #FylgjaTranslateCopy,
	#superclass : #FylgjaTranslation,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopy >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ self
		  writeCopyOf: aRelatedProvenanceEntity
		  croppingRelationsWith: aBlock
		  destinationWriter: aDestinationWriter
		  lookUp: aFylgjaLookUpContext
		  using: aFylgjaDerivativeModel
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopy >> isWrittenInContext: aProvenanceEntity context: aDestinationContext [
	^ (aProvenanceEntity isTypeReference ) not
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopy >> printOn: aStream [
 	aStream nextPutAll: 'Copy'
]
