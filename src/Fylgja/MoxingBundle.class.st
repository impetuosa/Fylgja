Class {
	#name : #MoxingBundle,
	#superclass : #FylgjaAbstractUI,
	#instVars : [
		'code',
		'projectTree',
		'shouldInformSelection',
		'modelAccessor'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #layout }
MoxingBundle class >> defaultLayout [

	^ SpPanedLayout newLeftToRight
		  positionOfSlider: 20 percent;
		  add: #projectTree;
		  add: #code
]

{ #category : #initialization }
MoxingBundle >> informSelection: item [

	shouldInformSelection ifTrue: [ self controller informSelection: item from: self ]
]

{ #category : #initialization }
MoxingBundle >> initialize [

	super initialize.
	shouldInformSelection := true
]

{ #category : #initialization }
MoxingBundle >> initializePresenters [

	super initializePresenters.

	code := self instantiate: MoxingCode.
	projectTree := self instantiate: MoxingTree.
	projectTree bundle: self.
	projectTree whenSelectionChangedDo: [ :e | 
		e selectedItem ifNotNil: [ :item | 
			self informSelection: item .
			item producesParseableCode ifTrue: [ 
				code visualizeSourcecode: item ] ] ]
]

{ #category : #initialization }
MoxingBundle >> installRuleOn: anEntity [

	self controller installRuleOn: anEntity
]

{ #category : #initialization }
MoxingBundle >> interestedInRuleApplication [
]

{ #category : #initialization }
MoxingBundle >> model [

	^ modelAccessor value: self controller
]

{ #category : #initialization }
MoxingBundle >> modelAccessor: anAccessor [
	modelAccessor := anAccessor.
	projectTree model: self model
]

{ #category : #initialization }
MoxingBundle >> ruleHasBeenAppliedSuccessfully [

	projectTree refreshWidgetWith: self model
]

{ #category : #initialization }
MoxingBundle >> shouldInformSelection: aBool [
 	 shouldInformSelection := aBool
]

{ #category : #initialization }
MoxingBundle >> whenTransferring: aBlock [

	projectTree whenTransferring: [ :transfer | 
		aBlock value: transfer value: self ]
]
