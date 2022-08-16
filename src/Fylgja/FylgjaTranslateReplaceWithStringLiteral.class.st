Class {
	#name : #FylgjaTranslateReplaceWithStringLiteral,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'string'
	],
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateReplaceWithStringLiteral class >> possibleWritingMessages [

	^ { #stringLiteral: }
]

{ #category : #'as yet unclassified' }
FylgjaTranslateReplaceWithStringLiteral >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock  destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [
	^ aDestinationWriter stringLiteral: string
]

{ #category : #testing }
FylgjaTranslateReplaceWithStringLiteral >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isExpression and: [ 
		  self canWriteOver: aWriter ]
]

{ #category : #'as yet unclassified' }
FylgjaTranslateReplaceWithStringLiteral >> printOn: aStream [

	aStream
		nextPutAll: 'Replace with String literal ';
		print: string
]

{ #category : #accessing }
FylgjaTranslateReplaceWithStringLiteral >> string: aString [ 
	string := aString 
]
