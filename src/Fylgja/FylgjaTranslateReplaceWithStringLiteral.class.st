Class {
	#name : #FylgjaTranslateReplaceWithStringLiteral,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'writer',
		'string'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateReplaceWithStringLiteral >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock  destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [
	^ aDestinationWriter stringLiteral: string
]

{ #category : #accessing }
FylgjaTranslateReplaceWithStringLiteral >> string: aString [ 
	string := aString 
]
