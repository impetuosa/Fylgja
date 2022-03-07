Class {
	#name : #FylgjaTranslateCopyAsClass,
	#superclass : #FylgjaTranslate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsClass >> applyTo: aProvenanceEntityRelation destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ aDestinationWriter writeDeclarationUnit: [ :unit | 
		  unit writeClass: [ :class | 
			  class visibility: #public.
			  class name: aProvenanceEntityRelation name.
			  class
				  writeCopyOf: aProvenanceEntityRelation
				  croppingWith: [ :col | 
					  col select: [ :relation | 
						  relation isMOObject not or: [ 
							  relation to isVariable or: [ relation to isInvocable ] ] ] ]
				  readingValues: [ :context :value | 
					  aFylgjaDerivativeModel
						  migrate: value
						  intoDestinationWriter: context
						  lookUp: aFylgjaLookUpContext ] ] ]
]
