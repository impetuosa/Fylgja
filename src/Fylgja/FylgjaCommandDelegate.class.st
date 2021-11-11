Class {
	#name : #FylgjaCommandDelegate,
	#superclass : #FylgjaCommands,
	#category : #'Fylgja-Commands'
}

{ #category : #'accessing - defaults' }
FylgjaCommandDelegate class >> defaultName [ 
	^ 'Delegate'
]

{ #category : #testing }
FylgjaCommandDelegate >> canBeExecuted [

	^ context selectedItem isKindOf: AlcixEntity
]
