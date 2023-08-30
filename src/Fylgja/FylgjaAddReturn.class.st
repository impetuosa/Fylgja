Class {
	#name : #FylgjaAddReturn,
	#superclass : #FylgjaModification,
	#instVars : [
		'expression'
	],
	#category : #'Fylgja-Rule-Transformations'
}

{ #category : #'instance creation' }
FylgjaAddReturn class >> possibleWritingMessages [

	^ { #writeReturn: }
]

{ #category : #accessing }
FylgjaAddReturn >> expression: anExpression [ 
	expression := anExpression
]

{ #category : #'instance creation' }
FylgjaAddReturn >> privateApplyOn: aWriter [

	^ aWriter writeReturn: [ :return | 
		  return writeExpression: [ :e | expression ] ]
]
