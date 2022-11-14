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
FylgjaWriterResolver >> privateResolveArtefact [

	entity language isMicrosoftAccess ifTrue: [ ^ MOModelWriter new ].
	entity language isJava ifTrue: [ ^ MOModelWriter new ].
	entity language isTypescript ifTrue: [ ^ MOModelWriter new ].
	self error: ' Language not supported '
]
