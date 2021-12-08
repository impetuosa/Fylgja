Class {
	#name : #FylgjaTranslateCopy,
	#superclass : #FylgjaTranslate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopy >> applyTo: element context: aMethod using: aFylgjaDerivativeModel [

	element isReference ifTrue: [ 
		^ self
			  writeCopyOf: element
			  withContext: aMethod
			  inWriter:
			  (aFylgjaDerivativeModel selectDestinationModelFor: aMethod)
				  writer
			  using: aFylgjaDerivativeModel ].


	^ aFylgjaDerivativeModel
		  writerFor: element
		  inContextOf: aMethod
		  do: [ :writingEntity :contextWriter | 
			  self
				  writeCopyOf: writingEntity
				  withContext: aMethod
				  inWriter: contextWriter
				  using: aFylgjaDerivativeModel ]
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopy >> printOn: aStream [
 	aStream nextPutAll: 'Copy'
]

{ #category : #writing }
FylgjaTranslateCopy >> writeCopyOf: element using: writingEntity withContext: aContext inWriter: contextWriter using: aFylgjaDerivativeModel [

	^ MOModelWriteTypeBasedResolver new
		  resolveWriterFor: writingEntity
		  context: aContext
		  writingContext: contextWriter
		  do: [ :elementWriter | 
			  elementWriter
				  writeCopyOf: element
				  readingValues: [ :context :value | 
					  aFylgjaDerivativeModel produce: value into: context ] ]
]

{ #category : #writing }
FylgjaTranslateCopy >> writeCopyOf: element withContext: aContext inWriter: contextWriter using: aFylgjaDerivativeModel [

	^ MOModelWriteTypeBasedResolver new
		  resolveWriterFor: element
		  context: aContext
		  writingContext: contextWriter
		  do: [ :elementWriter | 
			  elementWriter
				  writeCopyOf: element
				  readingValues: [ :context :value | 
					  aFylgjaDerivativeModel produce: value into: context ] ]
]
