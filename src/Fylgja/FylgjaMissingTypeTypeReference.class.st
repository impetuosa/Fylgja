Class {
	#name : #FylgjaMissingTypeTypeReference,
	#superclass : #FylgjaMappingErrorNode,
	#instVars : [
		'referenceTo',
		'relatedTypedEntity'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #visiting }
FylgjaMissingTypeTypeReference >> acceptVisitor: aMOTypescriptCodeGenerator [

	aMOTypescriptCodeGenerator visitTypeReference: self
]

{ #category : #'instance creation' }
FylgjaMissingTypeTypeReference >> for: anAlcixParameter [ 
	self shouldBeImplemented.
]

{ #category : #testing }
FylgjaMissingTypeTypeReference >> isVoid [

	^ referenceTo name asLowercase = #void
]

{ #category : #'as yet unclassified' }
FylgjaMissingTypeTypeReference >> name [

	^ referenceTo name
]

{ #category : #'as yet unclassified' }
FylgjaMissingTypeTypeReference >> printOn: aStream [

	aStream
		nextPutAll: 'Missing Type: ';
		nextPutAll: referenceTo name
]

{ #category : #accessing }
FylgjaMissingTypeTypeReference >> referenceTo: anAlcixPrimitiveType [ 
	referenceTo := anAlcixPrimitiveType 
]

{ #category : #'as yet unclassified' }
FylgjaMissingTypeTypeReference >> relatedTypedEntity: anAlcixParameter [

	relatedTypedEntity := anAlcixParameter
]
