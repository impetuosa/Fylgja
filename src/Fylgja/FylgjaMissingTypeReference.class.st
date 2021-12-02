Class {
	#name : #FylgjaMissingTypeReference,
	#superclass : #FylgjaMappingErrorNode,
	#instVars : [
		'type'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #visiting }
FylgjaMissingTypeReference >> acceptVisitor: aMOTypescriptCodeGenerator [

	aMOTypescriptCodeGenerator visitTypeReference: self
]

{ #category : #accessing }
FylgjaMissingTypeReference >> context: aMOClass [

	context := aMOClass
]

{ #category : #testing }
FylgjaMissingTypeReference >> isVoid [

	^ type name asLowercase = #void
]

{ #category : #'as yet unclassified' }
FylgjaMissingTypeReference >> name [

	^ type name
]

{ #category : #'as yet unclassified' }
FylgjaMissingTypeReference >> printOn: aStream [

	aStream
		nextPutAll: 'Missing Type: ';
		nextPutAll: type name
]

{ #category : #generated }
FylgjaMissingTypeReference >> type: aMOPrimitiveTypeReference [

	type := aMOPrimitiveTypeReference
]
