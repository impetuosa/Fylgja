Class {
	#name : #FylgjaProductionRule,
	#superclass : #FylgjaRule,
	#instVars : [
		'operation'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #'as yet unclassified' }
FylgjaProductionRule >> applyTo: anAlcixLocalVariable context: aMOMethod [

	^ operation applyTo: anAlcixLocalVariable context: aMOMethod
]

{ #category : #'as yet unclassified' }
FylgjaProductionRule >> applyTo: anAlcixLocalVariable context: aMOMethod using: aFylgjaModel [

	^ operation
		  applyTo: anAlcixLocalVariable
		  context: aMOMethod
		  using: aFylgjaModel
]

{ #category : #accessing }
FylgjaProductionRule >> operation: aFylgjaTranslateCopy [ 
	operation := aFylgjaTranslateCopy 
]
