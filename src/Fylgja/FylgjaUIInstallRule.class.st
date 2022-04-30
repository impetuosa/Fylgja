Class {
	#name : #FylgjaUIInstallRule,
	#superclass : #FylgjaUICommand,
	#category : #'Fylgja-UI-Commands'
}

{ #category : #'accessing - defaults' }
FylgjaUIInstallRule class >> defaultName [

	^ 'Install Rule'
]

{ #category : #executing }
FylgjaUIInstallRule >> canBeExecuted [

	^ self context selectedItems isEmptyOrNil not and: [ 
		  self context selectedItems allSatisfy: [ :a | a isRule ] ]
]

{ #category : #executing }
FylgjaUIInstallRule >> execute [

	^ self context installRule. 
]