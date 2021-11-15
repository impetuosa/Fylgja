Class {
	#name : #FylgjaMissingInvocableInvocation,
	#superclass : #FylgjaMappingErrorNode,
	#instVars : [
		'referenceTo',
		'relatedInvocation',
		'arguments'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #visiting }
FylgjaMissingInvocableInvocation >> acceptVisitor: aMOTypescriptCodeGenerator [

	aMOTypescriptCodeGenerator visitInvocableInvocation: self
]

{ #category : #accessing }
FylgjaMissingInvocableInvocation >> arguments [
	^ arguments
]

{ #category : #accessing }
FylgjaMissingInvocableInvocation >> arguments: aCollection [ 
	arguments := aCollection
]

{ #category : #'as yet unclassified' }
FylgjaMissingInvocableInvocation >> fullSelector [

	| candidate |
	referenceTo isString ifTrue: [ ^ referenceTo ].
	candidate := relatedInvocation candidates first.
	^ candidate userType name , '.' , candidate selector
]

{ #category : #accessing }
FylgjaMissingInvocableInvocation >> printOn: aStream [ 
	aStream nextPutAll: 'Invocation to missing invocable ', self fullSelector 
]

{ #category : #accessing }
FylgjaMissingInvocableInvocation >> referenceTo: anAlcixAttributeAccessor [ 
	referenceTo := anAlcixAttributeAccessor
]

{ #category : #'as yet unclassified' }
FylgjaMissingInvocableInvocation >> relatedInvocation: anAlcixInvocation [

	relatedInvocation := anAlcixInvocation
]
