Class {
	#name : #FylgjaTranslator,
	#superclass : #Object,
	#instVars : [
		'reader',
		'writer',
		'brush'
	],
	#category : #'Fylgja-Test'
}

{ #category : #accessing }
FylgjaTranslator >> brush: aMOMethodBrush [ 
	brush := aMOMethodBrush
]

{ #category : #accessing }
FylgjaTranslator >> reader: aFylgjaReader [ 
	reader := aFylgjaReader
]

{ #category : #accessing }
FylgjaTranslator >> writer: aMOJavaModelWriter [ 
	writer := aMOJavaModelWriter
]
