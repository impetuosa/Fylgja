Class {
	#name : #FylgjaUIPullUpRule,
	#superclass : #FylgjaUIRuleCommand,
	#category : #'Fylgja-UI-Commands-Rules'
}

{ #category : #'accessing - defaults' }
FylgjaUIPullUpRule class >> defaultName [

	^ 'Pull up rule'
]

{ #category : #testing }
FylgjaUIPullUpRule >> canBeExecuted [

	^ self context selectedItems isEmptyOrNil not and: [ 
		  self context selectedItems allSatisfy: [ :a | a isRule ] ]
]

{ #category : #executing }
FylgjaUIPullUpRule >> execute [

	self context pullUpSelectedRules
]
