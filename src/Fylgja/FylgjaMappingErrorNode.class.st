Class {
	#name : #FylgjaMappingErrorNode,
	#superclass : #MOLanguageObject,
	#instVars : [
		'destinationContext',
		'context'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #accessing }
FylgjaMappingErrorNode >> destinationContext: aMOClass [

	destinationContext := aMOClass
]

{ #category : #'as yet unclassified' }
FylgjaMappingErrorNode >> produce: anAlcixPrimitiveType into: aMOClass destination: aMOModel [
	" I am just here for being polymorphic. Not sure if i want to do this like this "
	^ self
]
