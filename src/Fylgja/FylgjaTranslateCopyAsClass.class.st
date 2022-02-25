Class {
	#name : #FylgjaTranslateCopyAsClass,
	#superclass : #FylgjaTranslate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsClass >> applyTo: aRelatedProvenanceEntity destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	aDestinationWriter writeDeclarationUnit: [ :unit | 
		unit writeClass: [ :class | 
			class visibility: #public.
			class name: aRelatedProvenanceEntity name.
			class
				writeCopyOf: aRelatedProvenanceEntity
				readingValues: [ :context :value | 
					aFylgjaDerivativeModel
						migrate: value
						intoDestinationWriter: context
						lookUp: aFylgjaLookUpContext ] ] ]
]
