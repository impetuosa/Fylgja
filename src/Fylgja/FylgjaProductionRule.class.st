Class {
	#name : #FylgjaProductionRule,
	#superclass : #FylgjaRule,
	#category : #'Fylgja-Rules'
}

{ #category : #'as yet unclassified' }
FylgjaProductionRule >> applyTo: anAlcixLocalVariable context: aMOMethod [

	^ operation applyTo: anAlcixLocalVariable context: aMOMethod
]

{ #category : #'as yet unclassified' }
FylgjaProductionRule >> applyTo: aProvenanceEntity context: aDestinationContext using: aFylgjaModel [

	^ operation
		  applyTo: aProvenanceEntity
		  context: aDestinationContext
		  using: aFylgjaModel
]

{ #category : #accessing }
FylgjaProductionRule >> operation: aFylgjaTranslateCopy [ 
	operation := aFylgjaTranslateCopy 
]

{ #category : #'as yet unclassified' }
FylgjaProductionRule >> printingSymbol [

	^ '=>>'
]
