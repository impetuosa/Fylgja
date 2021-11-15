Class {
	#name : #FylgjaMissingType,
	#superclass : #FylgjaMappingErrorNode,
	#instVars : [
		'referenceTo',
		'relatedTypedEntity'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #visiting }
FylgjaMissingType >> acceptVisitor: aMOTypescriptCodeGenerator [

	aMOTypescriptCodeGenerator visitTypeReference: self
]

{ #category : #'instance creation' }
FylgjaMissingType >> for: anAlcixParameter [ 
	self shouldBeImplemented.
]

{ #category : #testing }
FylgjaMissingType >> isVoid [

	^ referenceTo name asLowercase = #void
]

{ #category : #'as yet unclassified' }
FylgjaMissingType >> name [

	^ referenceTo name
]

{ #category : #'as yet unclassified' }
FylgjaMissingType >> printOn: aStream [

	aStream
		nextPutAll: 'Missing Type: ';
		nextPutAll: referenceTo name
]

{ #category : #accessing }
FylgjaMissingType >> referenceTo: anAlcixPrimitiveType [ 
	referenceTo := anAlcixPrimitiveType 
]

{ #category : #'as yet unclassified' }
FylgjaMissingType >> relatedTypedEntity: anAlcixParameter [

	relatedTypedEntity := anAlcixParameter
]
