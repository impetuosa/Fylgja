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

	entity language isMicrosoftAccess ifTrue: [ 
		(entity isKindOf: JinDAMEntity) ifTrue: [ ^ MOJinDAMModelReader new ].
		(entity isKindOf: MOObject) ifTrue: [ ^ MOModelAccessReader new ]. 
		self error: 'What reader?' ].
	entity language isJava ifTrue: [ ^ MOJavaModelReader new ].
	entity language isTypescript ifTrue: [ ^ MOTypescriptModelReader new ].
	self error: ' Language not supported '
]
