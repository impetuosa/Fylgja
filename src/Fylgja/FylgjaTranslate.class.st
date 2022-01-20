Class {
	#name : #FylgjaTranslate,
	#superclass : #FylgjaProduce,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslate >> applyTo: aProvenanceEntity context: aDestinationContext using: aFylgjaDerivativeModel [

	self subclassResponsibility 
]

{ #category : #testing }
FylgjaTranslate >> isDelegate [
	^ false 
]

{ #category : #writing }
FylgjaTranslate >> writeCopyOf: aProvenanceEntity withContext: aDestinationContext inWriter: aDestinationContextWriter using: aFylgjaDerivativeModel [

	^ MOModelWriteTypeBasedResolver new
		  resolveWriterFor: aProvenanceEntity
		  context: aDestinationContext
		  writingContext: aDestinationContextWriter
		  do: [ :elementWriter | 
			  elementWriter
				  writeCopyOf: aProvenanceEntity
				  readingValues: [ :context :value | 
					  aFylgjaDerivativeModel migrate: value into: context ] ]
]
