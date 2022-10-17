Class {
	#name : #FylgjaRuleViewer,
	#superclass : #FylgjaAbstractUI,
	#instVars : [
		'producing',
		'selectedItem',
		'adapting'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #layout }
FylgjaRuleViewer class >> buildCommandsGroupWith: presenterInstance forRoot: rootCommandGroup [
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
FylgjaRuleViewer class >> defaultLayout [

	^ SpPanedLayout newLeftToRight 
		  add: #producing;
		  add: #adapting;
		  yourself
]

{ #category : #layout }
FylgjaRuleViewer class >> registerBasicCommands: presenterInstance forGroup: rootCommandGroup [

	rootCommandGroup register:
		(FylgjaUIInspect forSpecContext: presenterInstance).
	
]

{ #category : #initialization }
FylgjaRuleViewer >> initializePresenters [

	super initializePresenters.
	
	producing := self newMrsTable. 
	adapting := self newMrsTable.
]

{ #category : #accessing }
FylgjaRuleViewer >> model: aFylgjaLookUpContext [

	
	adapting items: aFylgjaLookUpContext allPossibleBindingRules.
	producing items: aFylgjaLookUpContext allPossibleProducingRules
]

{ #category : #initialization }
FylgjaRuleViewer >> newMrsTable [

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
FylgjaRuleViewer >> registerToController [

	self controller registerForEntitySelected: self
]

{ #category : #initialization }
FylgjaRuleViewer >> selectedItem [

	^ selectedItem
]

{ #category : #accessing }
FylgjaRuleViewer >> selectedItems [

	^ { selectedItem }
]

{ #category : #accessing }
FylgjaRuleViewer >> updateSelectionTo: aSelection [

	self model: (self controller mrsFor: aSelection)
]
