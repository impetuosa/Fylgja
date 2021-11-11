Class {
	#name : #FylgjaTranslateBuilder,
	#superclass : #Object,
	#instVars : [
		'fylgja',
		'translate',
		'into',
		'translator',
		'possibleBrushes',
		'reader',
		'writer'
	],
	#category : #'Fylgja-Test'
}

{ #category : #building }
FylgjaTranslateBuilder >> build [

	possibleBrushes := (FylgjaBrushSetResolver newFor: into) resolve.
	possibleBrushes := (FylgjaBrushSelector newFor: translate) 
		                   chooseBetween: possibleBrushes.


	reader := (FylgjaReaderResolver newFor: translate) reader.
	writer := (FylgjaWriterResolver newFor: into) writer.


	self assert: possibleBrushes size = 1.
	translator := FylgjaTranslator new
		              reader: reader;
		              writer: writer;
		              brush: possibleBrushes anyOne;
		              yourself.
	^ translator
]

{ #category : #accessing }
FylgjaTranslateBuilder >> fylgja: aFylgjaModel [

	fylgja := aFylgjaModel
]

{ #category : #actions }
FylgjaTranslateBuilder >> install [
	
	
	fylgja installTranslation: translator from: translate to: into. 
]

{ #category : #generated }
FylgjaTranslateBuilder >> into: aMOJavaClass [ 
	into := aMOJavaClass 
]

{ #category : #translate }
FylgjaTranslateBuilder >> translate: anAlcixFunction [

	translate := anAlcixFunction
]
