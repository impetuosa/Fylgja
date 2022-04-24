Class {
	#name : #MoxingBundle,
	#superclass : #SpPresenter,
	#instVars : [
		'code',
		'projectTree'
	],
	#category : #'Fylgja-UI'
}

{ #category : #layout }
MoxingBundle class >> defaultLayout [

	^ SpPanedLayout newLeftToRight
		  positionOfSlider: 20 percent;
		  add: #projectTree;
		  add: #code
]

{ #category : #initialization }
MoxingBundle >> initializePresenters [

	super initializePresenters.
	code := self instantiate: MoxingCode.
	projectTree := self instantiate: MoxingTree.
	projectTree whenSelectionChangedDo: [ :e | 
		e selectedItem ifNotNil: [ :item | 
			item producesParseableCode ifTrue: [ 
				code visualizeSourcecode: item ] ] ]
]

{ #category : #initialization }
MoxingBundle >> model: aModel [

	projectTree selectEntity: aModel
]
