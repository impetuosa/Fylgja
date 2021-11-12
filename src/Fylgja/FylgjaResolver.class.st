Class {
	#name : #FylgjaResolver,
	#superclass : #Object,
	#instVars : [
		'fylgja',
		'entity'
	],
	#category : #'Fylgja-Test'
}

{ #category : #'as yet unclassified' }
FylgjaResolver class >> readerOn: aFylgja for: anEntity [

	^ FylgjaReaderResolver new
		  fylgja: aFylgja;
		  entity: anEntity;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaResolver class >> writerOn: aFylgja for: anEntity [

	^ FylgjaWriterResolver new
		  fylgja: aFylgja;
		  entity: anEntity;
		  yourself
]

{ #category : #navigating }
FylgjaResolver >> entity: anEntity [
	entity := anEntity 
]

{ #category : #navigating }
FylgjaResolver >> fylgja: anEntity [

	fylgja := anEntity
]

{ #category : #navigating }
FylgjaResolver >> resolve [ 
	^ self subclassResponsibility 
]
