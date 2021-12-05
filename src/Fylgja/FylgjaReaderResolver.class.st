Class {
	#name : #FylgjaReaderResolver,
	#superclass : #FylgjaResolver,
	#category : #'Fylgja-Test'
}

{ #category : #'instance creation' }
FylgjaReaderResolver class >> newFor: anAlcixFunction [ 
	^ self new 
]

{ #category : #options }
FylgjaReaderResolver >> privateResolveArtefact [

	entity language isMicrosoftAccess ifTrue: [ ^ MOAlceModelReader new ].
	entity language isJava ifTrue: [ ^ MOJavaModelReader new ].
	entity language isTypescript ifTrue: [ ^ MOTypescriptModelReader new ].
	self error: ' Language not supported '
]
