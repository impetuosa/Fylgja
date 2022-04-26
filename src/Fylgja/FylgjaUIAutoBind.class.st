Class {
	#name : #FylgjaUIAutoBind,
	#superclass : #FylgjaUICommand,
	#category : #'Fylgja-UI-Commands'
}

{ #category : #'accessing - defaults' }
FylgjaUIAutoBind class >> defaultName [

	^ 'Auto Bind'
]

{ #category : #testing }
FylgjaUIAutoBind >> canBeExecuted [

	^ self context selectedItems isEmptyOrNil not and: [ 
		  self context selectedItems allSatisfy: [ :a | a isFylgjaStub ] ]
]

{ #category : #executing }
FylgjaUIAutoBind >> execute [

	self context autoBindSelection
]
