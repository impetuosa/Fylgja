Class {
	#name : #MoxingBundle,
	#superclass : #SpPresenter,
	#instVars : [
		'code',
		'projectTree',
		'selectionChanged',
		'fylUi'
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
MoxingBundle >> fylUi: aFylU [

	fylUi := aFylU
]

{ #category : #initialization }
MoxingBundle >> initializePresenters [

	super initializePresenters.
	code := self instantiate: MoxingCode.
	projectTree := self instantiate: MoxingTree.
	projectTree bundle: self .
	projectTree whenSelectionChangedDo: [ :e | 
		e selectedItem ifNotNil: [ :item | 
			selectionChanged ifNotNil: [ selectionChanged value: item ].
			item producesParseableCode ifTrue: [ 
				code visualizeSourcecode: item ] ] ]
]

{ #category : #initialization }
MoxingBundle >> installRuleOn: anEntity [

	fylUi ifNotNil: [ :p | p installRuleOn: anEntity ]
]

{ #category : #initialization }
MoxingBundle >> model: aModel [

	projectTree model: aModel
]

{ #category : #initialization }
MoxingBundle >> whenSelectionChangedDo: aBlock [
	 selectionChanged := aBlock. 
	
]

{ #category : #initialization }
MoxingBundle >> whenTransferring: aBlock [

	projectTree whenTransferring: aBlock
]
