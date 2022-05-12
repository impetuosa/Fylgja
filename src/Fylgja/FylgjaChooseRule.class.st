Class {
	#name : #FylgjaChooseRule,
	#superclass : #SpPresenter,
	#instVars : [
		'table',
		'action',
		'title',
		'activatingBlock',
		'accept',
		'cancel',
		'cancelingBlock'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #layout }
FylgjaChooseRule class >> buildCommandsGroupWith: presenterInstance forRoot: rootCommandGroup [

	super
		buildCommandsGroupWith: presenterInstance
		forRoot: rootCommandGroup.
	rootCommandGroup register:
		(FylgjaUIAutoBind forSpecContext: presenterInstance).
	rootCommandGroup register:
		(FylgjaUIPullUpRule forSpecContext: presenterInstance).
	rootCommandGroup register:
		(FylgjaUIInspect forSpecContext: presenterInstance)
]

{ #category : #layout }
FylgjaChooseRule class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  borderWidth: 10;
		  spacing: 5;
		  add: #title height: 30;
		  add: #table;
		  add: (SpBoxLayout newLeftToRight
				   add: #accept;
				   add: #cancel;
				   yourself)
		  height: 30;
		  yourself
]

{ #category : #enumerating }
FylgjaChooseRule >> acceptRuleWith: aBlock [

	activatingBlock := aBlock
]

{ #category : #initialization }
FylgjaChooseRule >> activate [

	^ self activateRuleWith: table selectedItem value
]

{ #category : #initialization }
FylgjaChooseRule >> activateRuleWith: aRule [

	^ activatingBlock value: aRule
]

{ #category : #initialization }
FylgjaChooseRule >> activateWithRule: aRule [

	^ activatingBlock value: aRule
]

{ #category : #'as yet unclassified' }
FylgjaChooseRule >> cancelSelection [
	cancelingBlock value 
]

{ #category : #enumerating }
FylgjaChooseRule >> cancelWith: aBlock [

	cancelingBlock := aBlock
]

{ #category : #initialization }
FylgjaChooseRule >> initializePresenters [

	super initializePresenters.


	title := self newLabel.
	table := self newRuleChosingTable
		         beSingleSelection;
		         activateOnDoubleClick;
		         yourself.
	accept := self newButton
		          label: 'Accept';
		          action: [ self activate ].
	cancel := self newButton
		          label: 'Cancel';
		          action: [ self cancelSelection ]
]

{ #category : #enumerating }
FylgjaChooseRule >> newRuleChosingTable [

	^ self newTable
		  contextMenu: [ self rootCommandsGroup asMenuPresenter ];
		  addColumn: (SpIndexTableColumn new
				   title: 'Index';
				   sortFunction: #yourself ascending;
				   beNotExpandable;
				   width: 20;
				   yourself);
		  addColumn: (SpStringTableColumn new
				   title: 'Priority';
				   evaluated: [ :each | each value priority asString ];
				   beNotExpandable;
				   width: 20;
				   yourself);
		  addColumn: (SpStringTableColumn new
				   title: 'Origin';
				   evaluated: [ :each | each key name ];
				   beExpandable;
				   width: 50;
				   yourself);
		  addColumn: (SpStringTableColumn new
				   title: 'Operation ';
				   evaluated: [ :each | each value operation printString ];
				   beExpandable;
				   width: 200;
				   yourself);
		  addColumn: (SpStringTableColumn new
				   title: 'Condition ';
				   evaluated: [ :each | each value condition printString ];
				   beExpandable;
				   width: 50;
				   yourself);
		  yourself
]

{ #category : #initialization }
FylgjaChooseRule >> rules: aCcol [

	table items: aCcol.
	table selectItem: aCcol first.
]

{ #category : #enumerating }
FylgjaChooseRule >> selectedItem [

	^ table selectedItem
]

{ #category : #enumerating }
FylgjaChooseRule >> selectedItems [

	^ { self selectedItem }
]

{ #category : #accessing }
FylgjaChooseRule >> title: aString [

	title label: aString
]

{ #category : #initialization }
FylgjaChooseRule >> whenActivatedDo: aBlock [

	table whenActivatedDo: [ :rule | 
		self activateRuleWith: rule selectedItem value.
		aBlock cull: rule ]
]
