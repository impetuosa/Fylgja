Class {
	#name : #FylgjaDerivativeModel,
	#superclass : #Object,
	#instVars : [
		'fylgja',
		'derivativeModels'
	],
	#category : #'Fylgja-Model'
}

{ #category : #accessing }
FylgjaDerivativeModel >> fylgja: aFylgjaModel [ 
	fylgja := aFylgjaModel
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> initialize [

	super initialize.
	derivativeModels := OrderedCollection new
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> lookupRulesForProducing: aMOPrimitiveTypeReference toContext: aMOVariable [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> produce: anAlcixFunction into: aMOJavaClass [

	^ fylgja produce: anAlcixFunction into: aMOJavaClass using: self
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> readerFor: anAlcixLocalVariable [

	^ (FylgjaResolver readerOn: self for: anAlcixLocalVariable) resolve
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> selectDestinationModelFor: aMOMethod [

	^ derivativeModels
		  detect: [ :d | d entities includes: aMOMethod ]
		  ifNone: [ 
			  | model |
			  model := (fylgja selectDestinationModelFor: aMOMethod) derivative.
			  derivativeModels add: model.
			  model ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> writerFor: aMOVariable inContextOf: aMOBlock do: aFullBlockClosure [

	^ (self selectDestinationModelFor: aMOBlock) writer
		  updaterFor: aMOBlock
		  with: aMOVariable
		  do: aFullBlockClosure
]
