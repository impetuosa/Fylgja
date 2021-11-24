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

	entity language isMicrosoftAccess ifTrue: [ 
		^ MOMicrosoftAccessModelWriter new ].
	entity language isJava ifTrue: [ ^ MOJavaModelWriter new ].
	entity language isTypescript ifTrue: [ ^ MOTypescriptModelWriter new ].
	self error: ' Language not supported '
]
