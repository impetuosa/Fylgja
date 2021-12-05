Class {
	#name : #FylgjaTranslateCopy,
	#superclass : #FylgjaTranslate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopy >> applyTo: anAlcixLocalVariable context: aMOMethod [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopy >> applyTo: anAlcixLocalVariable context: aMOMethod using: aFylgjaDerivativeModel [

	| element |
	element := (aFylgjaDerivativeModel readerFor: anAlcixLocalVariable) 
		           read: anAlcixLocalVariable.

	^ aFylgjaDerivativeModel
		  writerFor: element
		  inContextOf: aMOMethod
		  do: [ :contextWriter | 
			  contextWriter
				  writeCopyOf: element
				  readingValues: [ :context :value | 
					  aFylgjaDerivativeModel produce: value into: context ] ]
]
