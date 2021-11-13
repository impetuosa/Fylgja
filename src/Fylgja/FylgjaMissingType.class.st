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

{ #category : #'as yet unclassified' }
FylgjaMissingType >> name [

	^ referenceTo name
]

{ #category : #accessing }
FylgjaMissingType >> referenceTo: anAlcixPrimitiveType [ 
	referenceTo := anAlcixPrimitiveType 
]

{ #category : #'as yet unclassified' }
FylgjaMissingType >> relatedTypedEntity: anAlcixParameter [

	relatedTypedEntity := anAlcixParameter
]
