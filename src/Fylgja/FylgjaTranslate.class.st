Class {
	#name : #FylgjaTranslate,
	#superclass : #FylgjaProduce,
	#instVars : [
		'result'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslate >> applyTo: aProvenanceEntity destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [
	self subclassResponsibility 
]

{ #category : #testing }
FylgjaTranslate >> isDelegate [
	^ false 
]

{ #category : #writing }
FylgjaTranslate >> writeCopyOf: aProvenanceEntity destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [
  
	^ MOModelWriteTypeBasedCopyResolver new
		  resolveWriterFor: aProvenanceEntity
		  writingContext: aDestinationWriter
		  do: [ :elementWriter | 
			  elementWriter
				  writeCopyOf: aProvenanceEntity
				  readingValues: [ :contextWriter :value | 
					  aFylgjaDerivativeModel
						  migrate: value
						  intoDestinationWriter: contextWriter
						  lookUp: aFylgjaLookUpContext ] ]
]
