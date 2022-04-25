Class {
	#name : #FylgjaUIUnInstallRule,
	#superclass : #FylgjaUICommand,
	#category : #'Fylgja-UI-Commands'
}

{ #category : #testing }
FylgjaUIUnInstallRule >> canBeExecuted [

	^ self context selectedItem isRule 
]
