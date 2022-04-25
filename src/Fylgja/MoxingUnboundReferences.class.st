Class {
	#name : #MoxingUnboundReferences,
	#superclass : #SpPresenter,
	#instVars : [
		'references'
	],
	#category : #'Fylgja-UI'
}

{ #category : #layout }
MoxingUnboundReferences class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #references;
		  yourself
]

{ #category : #initialization }
MoxingUnboundReferences >> initializePresenters [

	super initializePresenters.
	references := self newTable
]
