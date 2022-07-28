Class {
	#name : #FylgjaMRSViewer,
	#superclass : #FylgjaAbstractUI,
	#instVars : [
		'producing',
		'delegating',
		'selectedItem'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #layout }
FylgjaMRSViewer class >> buildCommandsGroupWith: presenterInstance forRoot: rootCommandGroup [
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
		
	
]

{ #category : #layout }
FylgjaMRSViewer class >> defaultLayout [

	^ SpPanedLayout newLeftToRight 
		  add: #producing;
		  add: #delegating;
		  yourself
]

{ #category : #layout }
FylgjaMRSViewer class >> registerBasicCommands: presenterInstance forGroup: rootCommandGroup [

	rootCommandGroup register:
		(FylgjaUIInspect forSpecContext: presenterInstance).
	
]

{ #category : #initialization }
FylgjaMRSViewer >> initializePresenters [

	super initializePresenters.
	
	producing := self newMrsTable. 
	delegating := self newMrsTable.
]

{ #category : #accessing }
FylgjaMRSViewer >> model: aFylgjaLookUpContext [

	
	delegating items: aFylgjaLookUpContext allPossibleDelegatingRules.
	producing items: aFylgjaLookUpContext allPossibleProducingRules
]

{ #category : #initialization }
FylgjaMRSViewer >> newMrsTable [

	| table |
	table := self newTable.
	table
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
				 beNotExpandable;
				 width: 50;
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: 'Rule ';
				 evaluated: [ :each | each value printString ]);
		whenSelectionChangedDo: [ :a | selectedItem := a selectedItem value ].
	^ table
]

{ #category : #initialization }
FylgjaMRSViewer >> registerToController [

	self controller registerForEntitySelected: self
]

{ #category : #initialization }
FylgjaMRSViewer >> selectedItem [

	^ selectedItem
]

{ #category : #accessing }
FylgjaMRSViewer >> selectedItems [

	^ { selectedItem }
]

{ #category : #accessing }
FylgjaMRSViewer >> updateSelectionTo: aSelection [

	self model: (self controller mrsFor: aSelection)
]
