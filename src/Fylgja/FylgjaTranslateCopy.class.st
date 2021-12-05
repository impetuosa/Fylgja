Class {
	#name : #FylgjaTranslateCopy,
	#superclass : #FylgjaTranslate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopy >> applyTo: anAlcixLocalVariable context: aMethod using: aFylgjaDerivativeModel [

	| element |
	element := (aFylgjaDerivativeModel readerFor: anAlcixLocalVariable) 
		           read: anAlcixLocalVariable.

	^ aFylgjaDerivativeModel
		  writerFor: element
		  inContextOf: aMethod
		  do: [ :contextWriter | 
			  contextWriter
				  writeCopyOf: element
				  readingValues: [ :context :value | 
					  aFylgjaDerivativeModel produce: value into: context ] ]
]
