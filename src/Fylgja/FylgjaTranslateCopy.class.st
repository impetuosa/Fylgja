Class {
	#name : #FylgjaTranslateCopy,
	#superclass : #FylgjaTranslate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopy >> applyTo: element context: aMethod using: aFylgjaDerivativeModel [


	^ aFylgjaDerivativeModel
		  writerFor: element
		  inContextOf: aMethod
		  do: [ :contextWriter | 
			  contextWriter
				  writeCopyOf: element
				  readingValues: [ :context :value | 
					  aFylgjaDerivativeModel produce: value into: context ] ]
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopy >> printOn: aStream [
 	aStream nextPutAll: 'Copy'
]
