Class {
	#name : #FylgjaTranslateCopyAsClass,
	#superclass : #FylgjaTranslate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsClass >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ aDestinationWriter writeDeclarationUnit: [ :unit | 
		  unit writeClass: [ :class | 
			  class visibility: #public.
			  class name: aProvenanceEntityRelation name.
			  class
				  writeCopyOf: aProvenanceEntityRelation
				  croppingRelationsWith: [ :col | 
					  (aBlock value: col) select: [ :relation | 
						  relation isMOObject not or: [ 
							  relation to isVariable or: [ relation to isInvocable ] ] ] ]
				  readingValues: [ :context :value | 
					  aFylgjaDerivativeModel
						  migrate: value
						  croppingRelationsWith: aBlock
						  intoDestinationWriter: context
						  lookUp: aFylgjaLookUpContext ]
				  bindingWithCandidates: [ :contextWriter :value | 
					  aFylgjaDerivativeModel
						  bind: value
						  croppingRelationsWith: aBlock
						  intoDestinationWriter: contextWriter
						  lookUp: aFylgjaLookUpContext ] ] ]
]
