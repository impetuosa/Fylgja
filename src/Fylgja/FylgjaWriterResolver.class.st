Class {
	#name : #FylgjaWriterResolver,
	#superclass : #FylgjaResolver,
	#category : #'Fylgja-Test'
}

{ #category : #'instance creation' }
FylgjaWriterResolver class >> newFor: aMOJavaClass [ 
	^ self new 
]

{ #category : #accessing }
FylgjaWriterResolver >> resolve [
	^ MOJavaModelWriter new . 
]
