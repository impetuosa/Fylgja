Class {
	#name : #FylgjaCommandGenerate,
	#superclass : #FylgjaCommands,
	#classInstVars : [
		'class'
	],
	#category : #'Fylgja-Commands'
}

{ #category : #'accessing - defaults' }
FylgjaCommandGenerate class >> defaultName [
	^ 'Generate'
]

{ #category : #executing }
FylgjaCommandGenerate >> canBeExecuted [

	^ context selectedItem isKindOf: AlcixEntity
]
