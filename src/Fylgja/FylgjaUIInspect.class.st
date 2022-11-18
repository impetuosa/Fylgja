Class {
	#name : #FylgjaUIInspect,
	#superclass : #FylgjaUICommand,
	#category : #'Fylgja-UI-Commands'
}

{ #category : #initialization }
FylgjaUIInspect class >> defaultIconName [

	^ #glamorousInspect
]

{ #category : #initialization }
FylgjaUIInspect class >> defaultName [

	^ 'Inspect'
]

{ #category : #executing }
FylgjaUIInspect >> canBeExecuted [

	^ true
]

{ #category : #executing }
FylgjaUIInspect >> execute [

	^ self context selectedItems size = 1
		  ifTrue: [ self context selectedItems first inspect ]
		  ifFalse: [ self context selectedItems inspect ]
]
