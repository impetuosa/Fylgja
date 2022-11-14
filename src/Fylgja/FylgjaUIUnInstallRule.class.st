Class {
	#name : #FylgjaUIUnInstallRule,
	#superclass : #FylgjaUIRuleCommand,
	#category : #'Fylgja-UI-Commands-Rules'
}

{ #category : #'accessing - defaults' }
FylgjaUIUnInstallRule class >> defaultName [

	^ 'Uninstall'
]

{ #category : #testing }
FylgjaUIUnInstallRule >> canBeExecuted [

	^ self context selectedItems isEmptyOrNil not and: [ 
		  self context selectedItems allSatisfy: [ :a | a isRule ] ]
]
