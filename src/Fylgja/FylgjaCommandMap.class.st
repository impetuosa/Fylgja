Class {
	#name : #FylgjaCommandMap,
	#superclass : #FylgjaCommands,
	#category : #'Fylgja-Commands'
}

{ #category : #'accessing - defaults' }
FylgjaCommandMap class >> defaultName [

	^ 'Map'
]

{ #category : #executing }
FylgjaCommandMap >> canBeExecuted [

	^ context selectedItem isKindOf: AlcixEntity
]

{ #category : #executing }
FylgjaCommandMap >> execute [
	self map: context selectedItem.
]
