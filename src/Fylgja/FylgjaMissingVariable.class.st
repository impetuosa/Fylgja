Class {
	#name : #FylgjaMissingVariable,
	#superclass : #FylgjaMappingErrorNode,
	#instVars : [
		'referenceTo',
		'relatedContext'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #visiting }
FylgjaMissingVariable >> acceptVisitor: aMOTypescriptCodeGenerator [

	^ aMOTypescriptCodeGenerator visitMissingVariable: self
]

{ #category : #'as yet unclassified' }
FylgjaMissingVariable >> printOn: aStream [

	aStream
		nextPutAll: 'Missing variable reference ';
		nextPutAll: self variableName
]

{ #category : #accessing }
FylgjaMissingVariable >> referenceTo [
	^ referenceTo 
]

{ #category : #accessing }
FylgjaMissingVariable >> referenceTo: aString [

	referenceTo := aString
]

{ #category : #'as yet unclassified' }
FylgjaMissingVariable >> relatedContext: aVBArgumentNode [ 
	relatedContext := aVBArgumentNode.
	(aVBArgumentNode isKindOf: AlcixInvocation ) ifTrue: [ self halt  ]
]

{ #category : #accessing }
FylgjaMissingVariable >> variableName [

	^ referenceTo isString
		  ifTrue: [ referenceTo ]
		  ifFalse: [ referenceTo name ]
]
