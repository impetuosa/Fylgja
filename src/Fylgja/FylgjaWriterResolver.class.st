Class {
	#name : #FylgjaWriterResolver,
	#superclass : #Object,
	#category : #'Fylgja-Test'
}

{ #category : #'instance creation' }
FylgjaWriterResolver class >> newFor: aMOJavaClass [ 
	^ self new 
]

{ #category : #accessing }
FylgjaWriterResolver >> writer [
	^ MOJavaModelWriter new . 
]
