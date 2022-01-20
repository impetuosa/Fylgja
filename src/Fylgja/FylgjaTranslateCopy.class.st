Class {
	#name : #FylgjaTranslateCopy,
	#superclass : #FylgjaTranslate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopy >> applyTo: aProvenanceEntity context: aDestinationContext using: aFylgjaDerivativeModel [

	(self isWrittenInContext: aProvenanceEntity context: aDestinationContext) ifFalse: [ 
		^ self
			  writeCopyOf: aProvenanceEntity
			  withContext: aDestinationContext
			  inWriter:
			  (aFylgjaDerivativeModel selectDestinationModelFor: aDestinationContext)
				  writer
			  using: aFylgjaDerivativeModel ].

	^ aFylgjaDerivativeModel
		  writerFor: aProvenanceEntity
		  inContextOf: aDestinationContext
		  do: [ :writingEntity :contextWriter | 
			  self
				  writeCopyOf: writingEntity
				  withContext: aDestinationContext
				  inWriter: contextWriter
				  using: aFylgjaDerivativeModel ]
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopy >> isWrittenInContext: aProvenanceEntity context: aDestinationContext [
	^ (aProvenanceEntity isTypeReference ) not
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopy >> printOn: aStream [
 	aStream nextPutAll: 'Copy'
]
