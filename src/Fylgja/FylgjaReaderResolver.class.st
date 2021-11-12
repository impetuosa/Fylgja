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

	^ MOAlceModelReader new
		  mapper: (FylgjaReadMapper new
				   fylgja: fylgja;
				   yourself);
		  yourself
]
