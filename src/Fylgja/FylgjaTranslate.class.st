Class {
	#name : #FylgjaTranslate,
	#superclass : #FylgjaProduce,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslate >> applyTo: aRelatedProvenanceEntity destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [
	self subclassResponsibility 
]

{ #category : #testing }
FylgjaTranslate >> isDelegate [
	^ false 
]

{ #category : #writing }
FylgjaTranslate >> writeCopyOf: aProvenanceEntityRelation destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [
  
	^ MOModelWriteTypeBasedCopyResolver new
		  resolveWriterFor: aProvenanceEntityRelation
		  writingContext: aDestinationWriter
		  do: [ :elementWriter | 
			  elementWriter
				  writeCopyOf: aProvenanceEntityRelation
				  readingValues: [ :contextWriter :value | 
					  aFylgjaDerivativeModel
						  migrate: value
						  intoDestinationWriter: contextWriter
						  lookUp: aFylgjaLookUpContext ] ]
]
