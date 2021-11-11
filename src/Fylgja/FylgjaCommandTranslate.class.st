Class {
	#name : #FylgjaCommandTranslate,
	#superclass : #FylgjaCommands,
	#category : #'Fylgja-Commands'
}

{ #category : #'accessing - defaults' }
FylgjaCommandTranslate class >> defaultName [
	^ 'Translate'
]

{ #category : #testing }
FylgjaCommandTranslate >> canBeExecuted [

	^ context selectedItem isKindOf: AlcixEntity
]

{ #category : #executing }
FylgjaCommandTranslate >> execute [
	self shouldBeImplemented.
]
