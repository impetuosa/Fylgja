Class {
	#name : #FylgjaReaderResolver,
	#superclass : #Object,
	#category : #'Fylgja-Test'
}

{ #category : #'instance creation' }
FylgjaReaderResolver class >> newFor: anAlcixFunction [ 
	^ self new 
]

{ #category : #options }
FylgjaReaderResolver >> reader [
	^ FylgjaReader new 
]
