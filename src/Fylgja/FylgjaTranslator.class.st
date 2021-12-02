Class {
	#name : #FylgjaTranslator,
	#superclass : #Object,
	#instVars : [
		'writer',
		'brush',
		'reader'
	],
	#category : #'Fylgja-Test'
}

{ #category : #accessing }
FylgjaTranslator >> brush: aMOMethodBrush [ 
	brush := aMOMethodBrush
]

{ #category : #'as yet unclassified' }
FylgjaTranslator >> produce: anAlcixFunction into: aMOClass destination: aMOModel [

	| entity context |
	context := aMOModel writer writeCopyOf: aMOClass.
	entity := reader read: anAlcixFunction context: context of: aMOModel.



	writer surface: context.
	writer model: aMOModel.
	writer brush: brush.

	^ writer write: entity
]

{ #category : #accessing }
FylgjaTranslator >> reader: aMOAlceModelReader [ 
	reader := aMOAlceModelReader
]

{ #category : #accessing }
FylgjaTranslator >> writer: aMOJavaModelWriter [ 
	writer := aMOJavaModelWriter
]
