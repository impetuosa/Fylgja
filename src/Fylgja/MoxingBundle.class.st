Class {
	#name : #MoxingBundle,
	#superclass : #FylgjaAbstractUI,
	#instVars : [
		'code',
		'projectTree',
		'shouldInformSelection',
		'modelAccessor',
		'popover'
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
MoxingBundle >> newRuleChosing [

	^ self instantiate: FylgjaChooseRule
]

{ #category : #enumerating }
MoxingBundle >> promptUser: aTitle forChosingRule: aCollection thenDo: aBlock [

	popover ifNotNil: [ popover dismiss ].
	(popover := self newPopover)
		relativeTo: projectTree;
		position: SpPopoverPosition left;
		presenter: (SpPresenter new
				 layout: (SpBoxLayout newLeftToRight
						  add: (SpBoxLayout newTopToBottom
								   borderWidth: 10;
								   spacing: 5;
								   add: (self newRuleChosing
										    rules: aCollection;
										    title: aTitle;
										    acceptRuleWith: [ :r | 
											    popover dismiss.
											    aBlock value: r value: self model ];
										    cancelWith: [ popover dismiss ];
										    yourself)
								   height: 400;
								   yourself)
						  width: 800;
						  yourself);
				 yourself);
		popup
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
