Class {
	#name : #MoxingTree,
	#superclass : #SpPresenter,
	#instVars : [
		'tree',
		'model',
		'whenSelected',
		'bundle'
	],
	#category : #'Fylgja-UI'
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
			transfer passenger allSatisfy: #isDeclaration ];
		acceptDrop: [ :transfer | 
			tree items: tree items , transfer passenger ].
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
MoxingTree >> model: aModel [

	model := aModel.
	self selectEntity: model
]

{ #category : #initialization }
MoxingTree >> selectEntity: anEntity [

	tree items: (self childrenFor: anEntity)
]

{ #category : #accessing }
MoxingTree >> selectedItem [
	^ tree selectedItem
]

{ #category : #enumerating }
MoxingTree >> whenSelectionChangedDo: aFullBlockClosure [

	^ tree whenSelectionChangedDo: aFullBlockClosure
]

{ #category : #initialization }
MoxingTree >> whenTransferring: aFullBlockClosure [

	tree acceptDrop: aFullBlockClosure
]
