"
#Translation operations

These operations are of the translation kind. All of them inherit from the FylgjaProduction class.
Translations have a fine granularity of transformation and they act over language elements. 
The translation proposed in this hierarchy are of the kind of producing equivalent semantic elements such as translating a On Error Go To from access to Try Catch in java or typescript. 

As this operations are based on language concepts, they can be reuse over different technologies in some cases.
Operations such as operator replacement (to transform a & b to a + b) can be reused across many languages. 
Operations such as On Error Go To from access to Try Catch, can be used to many target technologies (all those using try catch) but only appliable over Microsoft Access code, as the statement on error go to it is only existing in VB.  
"
Class {
	#name : #FylgjaTranslation,
	#superclass : #FylgjaProduction,
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #'instance creation' }
FylgjaTranslation class >> holdsPackageDocumentation [

	^ self = FylgjaTranslation
]

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
