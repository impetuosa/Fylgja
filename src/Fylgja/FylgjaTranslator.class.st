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

{ #category : #'as yet unclassified' }
FylgjaTranslator >> produce: anAlcixFunction into: aMOClass [

	writer surface: aMOClass.
	writer brush: brush.
	writer write: (reader read: anAlcixFunction context: aMOClass).
	
]

{ #category : #'as yet unclassified' }
FylgjaTranslator >> produce: anAlcixFunction into: aMOClass destination: aMOModel [

	| entity |
	writer surface: aMOClass.
	writer model: aMOModel.
	writer brush: brush.
	entity := reader read: anAlcixFunction context: aMOClass of: aMOModel.
	^ writer write: entity with: reader model
]

{ #category : #accessing }
FylgjaTranslator >> reader: aFylgjaReader [ 
	reader := aFylgjaReader
]

{ #category : #accessing }
FylgjaTranslator >> writer: aMOJavaModelWriter [ 
	writer := aMOJavaModelWriter
]
