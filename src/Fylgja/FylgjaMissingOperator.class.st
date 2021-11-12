Class {
	#name : #FylgjaMissingOperator,
	#superclass : #FylgjaMappingErrorNode,
	#instVars : [
		'operator',
		'left',
		'right'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #visiting }
FylgjaMissingOperator >> acceptVisitor: aMOTypescriptCodeGenerator [

	aMOTypescriptCodeGenerator visitOperator: self
]

{ #category : #'as yet unclassified' }
FylgjaMissingOperator >> argumentOrSelf: aFylgjaMissingInvocable [ 
	left := aFylgjaMissingInvocable
]

{ #category : #'as yet unclassified' }
FylgjaMissingOperator >> furtherArguments: aCollection [ 
	right := aCollection 
]

{ #category : #accessing }
FylgjaMissingOperator >> left [
	^ left
]

{ #category : #accessing }
FylgjaMissingOperator >> operator [
	^ operator
]

{ #category : #accessing }
FylgjaMissingOperator >> operator: aString [ 
	operator := aString
]

{ #category : #accessing }
FylgjaMissingOperator >> right [
	^ right
]
