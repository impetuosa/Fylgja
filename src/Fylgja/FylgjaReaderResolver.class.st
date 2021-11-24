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
FylgjaReaderResolver >> resolve [

	entity language isMicrosoftAccess ifTrue: [ 
		^ MOAlceModelReader new
			  mapper: (FylgjaReadMapper new
					   fylgja: fylgja;
					   yourself);
			  yourself ].
	entity language isJava ifTrue: [ 
		^ MOJavaModelReader new
			  mapper: (FylgjaReadMapper new
					   fylgja: fylgja;
					   yourself);
			  yourself ].
	entity language isTypescript ifTrue: [ 
		^ MOTypescriptModelReader new
			  mapper: (FylgjaReadMapper new
					   fylgja: fylgja;
					   yourself);
			  yourself ].
	self error: ' Language not supported '
]
