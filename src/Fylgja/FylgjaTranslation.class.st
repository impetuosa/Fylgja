Class {
	#name : #FylgjaTranslation,
	#superclass : #FylgjaProduction,
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #writing }
FylgjaTranslation >> writeCopyOf: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

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
						  mapEntity: destinationEntity
						  as: provenanceEntityCandidate
						  croppingRelationsWith: aBlock
						  usingWriter: contextWriter
						  lookUp: aFylgjaLookUpContext ] ]
]
