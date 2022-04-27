Class {
	#name : #MoxingTree,
	#superclass : #SpPresenter,
	#instVars : [
		'tree',
		'model',
		'whenSelected',
		'bundle',
		'manageTransfer'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #layout }
MoxingTree class >> buildCommandsGroupWith: presenterInstance forRoot: rootCommandGroup [

	super
		buildCommandsGroupWith: presenterInstance
		forRoot: rootCommandGroup.
	rootCommandGroup register:
		(FylgjaUIInspect forSpecContext: presenterInstance).

	rootCommandGroup register:
		(FylgjaUIInstallRule forSpecContext: presenterInstance)
]

{ #category : #layout }
MoxingTree class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #tree;
		  yourself
]

{ #category : #initialization }
MoxingTree >> bundle: aBundle [

	bundle := aBundle
]

{ #category : #initialization }
MoxingTree >> childrenFor: anEntry [

	| entity |
	entity := anEntry isAssociation
		          ifTrue: [ anEntry value ]
		          ifFalse: [ anEntry ].
	entity isCollection ifTrue: [ ^ {  } ].
	^ entity isModelOrDerivative
		  ifTrue: [ { entity root } ]
		  ifFalse: [ 
			  entity allContainments
				  reject: [ :a | a isKindOf: MOEmptyBlock ]
				  thenCollect: [ :m | model entityFor: m ] ]
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

	tree := self newTreeTable.
	tree contextMenu: [ self rootCommandsGroup asMenuPresenter ].
	tree dragEnabled: true.
	tree dropEnabled: true.
	tree
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
MoxingTree >> refreshWidget [

	| path |
	tree selectedItem
		ifNotNil: [ 
			path := tree selectionMode selectedPath.
			self model: model.
			tree selectPath: path , { 1 } scrollToSelection: true ]
		ifNil: [ self model: model ]
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
