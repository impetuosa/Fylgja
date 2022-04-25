Class {
	#name : #FylgjaMRSViewer,
	#superclass : #SpPresenter,
	#instVars : [
		'mapping',
		'producing',
		'delegating',
		'selectedItem'
	],
	#category : #'Fylgja-UI'
}

{ #category : #layout }
FylgjaMRSViewer class >> buildCommandsGroupWith: presenterInstance forRoot: rootCommandGroup [

	super
		buildCommandsGroupWith: presenterInstance
		forRoot: rootCommandGroup.
	rootCommandGroup register:
		(FylgjaUIInspect forSpecContext: presenterInstance).
	rootCommandGroup register:
		(FylgjaUIUnInstallRule forSpecContext: presenterInstance)
]

{ #category : #layout }
FylgjaMRSViewer class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #mapping;
		  add: #producing;
		  add: #delegating;
		  yourself
]

{ #category : #initialization }
FylgjaMRSViewer >> initializePresenters [

	super initializePresenters.
	mapping := self newMrsTable. 
	producing := self newMrsTable. 
	delegating := self newMrsTable.
]

{ #category : #accessing }
FylgjaMRSViewer >> model: aFylgjaLookUpContext [

	mapping items: aFylgjaLookUpContext allPossibleMappingRules.
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
				 evaluated: [ :each | each value priority asString ]);
		addColumn: (SpStringTableColumn new
				 title: 'Origin';
				 evaluated: [ :each | each key name ]);
		addColumn: (SpStringTableColumn new
				 title: 'Rule ';
				 evaluated: [ :each | each value printString ]);
		whenSelectionChangedDo: [ :a | selectedItem := a selectedItem value ].
	^ table
]

{ #category : #initialization }
FylgjaMRSViewer >> selectedItem [

	^ selectedItem
]
