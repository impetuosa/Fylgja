Class {
	#name : #MoxingTree,
	#superclass : #SpPresenter,
	#instVars : [
		'tree',
		'whenSelected',
		'bundle',
		'manageTransfer',
		'model'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #layout }
MoxingTree class >> buildCommandsGroupWith: presenterInstance forRoot: rootCommandGroup [

	super
		buildCommandsGroupWith: presenterInstance
		forRoot: rootCommandGroup.

	self
		registerBasicCommands: presenterInstance
		forGroup: rootCommandGroup.

	FylgjaUIRuleCommand
		addAsGroupNamed: 'Rules'
		into: rootCommandGroup
		for: presenterInstance.

	FylgjaUIDeclarationCommand
		addAsGroupNamed: 'Declarations'
		into: rootCommandGroup
		for: presenterInstance.
		
	FylgjaUITransformCommand
		addAsGroupNamed: 'Transforms'
		into: rootCommandGroup
		for: presenterInstance
]

{ #category : #layout }
MoxingTree class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #tree;
		  yourself
]

{ #category : #layout }
MoxingTree class >> registerBasicCommands: presenterInstance forGroup: rootCommandGroup [

	rootCommandGroup register:
		(FylgjaUIInspect forSpecContext: presenterInstance).
	rootCommandGroup register:
		(FylgjaUIInspectObject forSpecContext: presenterInstance).
	rootCommandGroup register:
		(FylgjaUIUsersAndSenders forSpecContext: presenterInstance)
]

{ #category : #initialization }
MoxingTree >> bundle: aBundle [

	bundle := aBundle
]

{ #category : #initialization }
MoxingTree >> childrenFor: anEntry [

	| entity |
	
	entity := self entityFor: anEntry.
	entity isCollection ifTrue: [ ^ {  } ].
	^ entity isModelOrDerivative
		  ifTrue: [ { (self entityFor: entity root) } ]
		  ifFalse: [ 
			  [ 
			  entity childrenForTree
				  reject: [ :a | a species = MOEmptyBlock ]
				  thenCollect: [ :m | self entityFor: m ] ]
				  on: Error
				  do: [ :e | e haltOnce ] ]
]

{ #category : #initialization }
MoxingTree >> controller [

	^ self owner controller
]

{ #category : #initialization }
MoxingTree >> entityFor: anEntry [

	^ model entityFor: anEntry
]

{ #category : #initialization }
MoxingTree >> iconFor: anEntry [

	^ (anEntry isKindOf: Association)
		  ifTrue: [ MoxingIcons iconForEntryName: anEntry key ]
		  ifFalse: [ MoxingIcons iconFor: anEntry ]
]

{ #category : #initialization }
MoxingTree >> imageRepresentationFor: each [

	^ (MOElementToUIString new toString: each) asStringMorph
]

{ #category : #initialization }
MoxingTree >> initializePresenters [

	super initializePresenters.

	tree := self instantiate: SpTreeTablePresenter.
	tree contextMenu: [ self rootCommandsGroup asMenuPresenter ].
	tree dragEnabled: true.
	tree dropEnabled: true.
	tree
		beMultipleSelection;
		wantsDrop: [ :transfer | 
			transfer target isNotNil and: [ 
					transfer passenger allSatisfy: [ :a | a isKindOf: MODeclaration ] ] ];
		acceptDrop: [ :transfer | self manageTransfer: transfer ].
	tree
		addColumn: (SpCompositeTableColumn new
				 title: '';
				 addColumn:
					 ((SpImageTableColumn evaluated: [ :each | self iconFor: each ])
						  width: 20;
						  yourself);
				 addColumn: (SpImageTableColumn evaluated: [ :each | 
						  self imageRepresentationFor: each ]);
				 yourself);
		children: [ :entry | self childrenFor: entry ]
]

{ #category : #accessing }
MoxingTree >> installRule [

	bundle ifNotNil: [ bundle installRuleOn: self selectedItem ]
]

{ #category : #initialization }
MoxingTree >> manageTransfer: aTransfer [

	tree selectItem: aTransfer target.
	manageTransfer ifNil: [ ^ self ].
	manageTransfer value: aTransfer
]

{ #category : #initialization }
MoxingTree >> model: aModel [

	model := aModel. 
	tree items: (self childrenFor: aModel).
]

{ #category : #enumerating }
MoxingTree >> refreshWidgetWith: aModel [ 

	| path |
	tree selectedItem
		ifNotNil: [ 
			path := tree selectionMode selectedPath.
			self model: aModel.
			tree selectPath: path , { 1 } scrollToSelection: true ]
		ifNil: [ self model: model ]
]

{ #category : #initialization }
MoxingTree >> ruleHasBeenAppliedSuccessfully [

	owner ruleHasBeenAppliedSuccessfully
]

{ #category : #accessing }
MoxingTree >> selectedItem [
	^ tree selectedItem
]

{ #category : #accessing }
MoxingTree >> selectedItems [

	^ { self selectedItem }
]

{ #category : #enumerating }
MoxingTree >> whenSelectionChangedDo: aFullBlockClosure [

	^ tree whenSelectionChangedDo: aFullBlockClosure
]

{ #category : #initialization }
MoxingTree >> whenTransferring: aFullBlockClosure [

	manageTransfer := aFullBlockClosure
]
