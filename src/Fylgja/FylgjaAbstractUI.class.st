Class {
	#name : #FylgjaAbstractUI,
	#superclass : #SpPresenter,
	#category : #'Fylgja-UI'
}

{ #category : #private }
FylgjaAbstractUI >> application [

	^ application ifNil: [ owner application ]
]

{ #category : #private }
FylgjaAbstractUI >> controller [

	^ self application controller
]

{ #category : #private }
FylgjaAbstractUI >> initializePresenters [

	super initializePresenters.
	self registerToController
]

{ #category : #private }
FylgjaAbstractUI >> registerToController [
]

{ #category : #'as yet unclassified' }
FylgjaAbstractUI >> saveRules [

	self controller saveRules
]
