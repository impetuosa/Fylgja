Class {
	#name : #FylgjaOperation,
	#superclass : #Object,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #testing }
FylgjaOperation >> isBinding [ 
	^ false. 
]

{ #category : #writing }
FylgjaOperation >> writeCopyOf: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ MOModelWriteTypeBasedCopyResolver new
		  resolveWriterFor: aProvenanceEntityRelation
		  writingContext: aDestinationWriter
		  do: [ :elementWriter | 
			  elementWriter
				  writeCopyOf: aProvenanceEntityRelation
				  croppingRelationsWith: aBlock
				  readingValues: [ :contextWriter :value | 
					  aFylgjaDerivativeModel
						  migrate: value
						  croppingRelationsWith: aBlock
						  intoDestinationWriter: contextWriter
						  lookUp: aFylgjaLookUpContext ]
				  bindingWithCandidates: [ 
					  :contextWriter 
					  :provenanceEntityCandidate 
					  :destinationEntity | 
					  aFylgjaDerivativeModel
						  bindAndReturnEntity: destinationEntity
						  as: provenanceEntityCandidate
						  croppingRelationsWith: aBlock
						  usingWriter: contextWriter
						  lookUp: aFylgjaLookUpContext ] ]
]
