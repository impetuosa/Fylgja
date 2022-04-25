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

	^ self context selectedItem anchor isNotNil
]

{ #category : #executing }
FylgjaUIInstallRule >> execute [

	^ self context installRule. 
]
