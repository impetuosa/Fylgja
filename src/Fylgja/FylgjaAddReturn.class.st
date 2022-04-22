Class {
	#name : #FylgjaAddReturn,
	#superclass : #FylgjaModification,
	#instVars : [
		'expression'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddReturn >> applyOn: aWriter [

	^ aWriter writeReturn: [ :return | 
		  return writeExpression: [ :e | expression ] ]
]

{ #category : #accessing }
FylgjaAddReturn >> expression: anExpression [ 
	expression := anExpression
]
