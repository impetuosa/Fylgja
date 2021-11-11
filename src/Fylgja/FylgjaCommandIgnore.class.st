Class {
	#name : #FylgjaCommandIgnore,
	#superclass : #FylgjaCommands,
	#category : #'Fylgja-Commands'
}

{ #category : #'accessing - defaults' }
FylgjaCommandIgnore class >> defaultName [

	^ 'Ignore'
]

{ #category : #executing }
FylgjaCommandIgnore >> canBeExecuted [

	^ context selectedItem isKindOf: AlcixEntity
]

{ #category : #executing }
FylgjaCommandIgnore >> execute [
	self shouldBeImplemented.
]
