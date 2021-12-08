Class {
	#name : #FylgjaDerivationResult,
	#superclass : #Object,
	#instVars : [
		'derivative',
		'result'
	],
	#category : #'Fylgja-Model'
}

{ #category : #accessing }
FylgjaDerivationResult >> derivative [
	^ derivative
]

{ #category : #accessing }
FylgjaDerivationResult >> derivative: aFylgjaDerivativeModel [ 
	derivative := aFylgjaDerivativeModel
]

{ #category : #accessing }
FylgjaDerivationResult >> entity [
	self shouldBeImplemented.
]

{ #category : #accessing }
FylgjaDerivationResult >> result [
	^ result
]

{ #category : #accessing }
FylgjaDerivationResult >> result: aMOBlock [ 
	result := aMOBlock
]
