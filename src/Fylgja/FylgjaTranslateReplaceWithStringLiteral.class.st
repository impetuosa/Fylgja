Class {
	#name : #FylgjaTranslateReplaceWithStringLiteral,
	#superclass : #FylgjaTranslate,
	#instVars : [
		'writer',
		'string'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateReplaceWithStringLiteral >> applyTo: aProvenanceEntity context: aDestinationContext using: aFylgjaDerivativeModel [

	writer := (aFylgjaDerivativeModel selectDerivativeModelFor:
		           aDestinationContext) writer.
	^ writer stringLiteral: string
]

{ #category : #accessing }
FylgjaTranslateReplaceWithStringLiteral >> string: aString [ 
	string := aString 
]
