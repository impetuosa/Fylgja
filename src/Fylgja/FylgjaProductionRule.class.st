Class {
	#name : #FylgjaProductionRule,
	#superclass : #FylgjaRule,
	#category : #'Fylgja-Rules'
}

{ #category : #'as yet unclassified' }
FylgjaProductionRule >> applyTo: aProvenanceEntity context: aDestinationContext using: aFylgjaModel [

	^ operation
		  applyTo: aProvenanceEntity
		  context: aDestinationContext
		  using: aFylgjaModel
]

{ #category : #'as yet unclassified' }
FylgjaProductionRule >> applyTo: aRelatedProvenanceEntity destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ operation
		  applyTo: aRelatedProvenanceEntity
		  destinationWriter: aDestinationWriter
		  lookUp: aFylgjaLookUpContext
		  using: aFylgjaDerivativeModel
]

{ #category : #accessing }
FylgjaProductionRule >> operation: aFylgjaTranslateCopy [ 
	operation := aFylgjaTranslateCopy 
]

{ #category : #'as yet unclassified' }
FylgjaProductionRule >> printingSymbol [

	^ '=>>'
]
