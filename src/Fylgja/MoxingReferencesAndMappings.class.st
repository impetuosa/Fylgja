Class {
	#name : #MoxingReferencesAndMappings,
	#superclass : #FylgjaAbstractUI,
	#instVars : [
		'references',
		'autoBind',
		'mappings',
		'refTitle',
		'mapTitle',
		'selectedItems',
		'lastSelection'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #layout }
MoxingReferencesAndMappings class >> buildCommandsGroupWith: presenterInstance forRoot: rootCommandGroup [

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

	FylgjaUITransformCommand
		addAsGroupNamed: 'Transforms'
		into: rootCommandGroup
		for: presenterInstance.
		
	FylgjaUIMigrationCommand
		addAsGroupNamed: 'Migrations'
		into: rootCommandGroup
		for: presenterInstance
]

{ #category : #layout }
MoxingReferencesAndMappings class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #autoBind height: self toolbarHeight;
		  add: (SpPanedLayout newLeftToRight
				   positionOfSlider: 50 percent;
				   add: (SpBoxLayout newTopToBottom
						    add: #refTitle height: 30;
						    add: #references;
						    yourself);
				   add: (SpBoxLayout newTopToBottom
						    add: #mapTitle height: 30;
						    add: #mappings;
						    yourself);
				   yourself);
		  yourself
]

{ #category : #layout }
MoxingReferencesAndMappings class >> registerBasicCommands: presenterInstance forGroup: rootCommandGroup [

	rootCommandGroup register:
		(FylgjaUIInspect forSpecContext: presenterInstance).
	rootCommandGroup register:
		(FylgjaUIAutoBind forSpecContext: presenterInstance)
]

{ #category : #accessing }
MoxingReferencesAndMappings >> autoBind [

	self controller autoBind: references items.
	self refreshWidget
]

{ #category : #'as yet unclassified' }
MoxingReferencesAndMappings >> autoBindSelection [

	self controller autoBind: references selectedItems.
	self refreshWidget
]

{ #category : #initialization }
MoxingReferencesAndMappings >> initializePresenters [

	super initializePresenters.
	autoBind := self newButton
		            label: 'Auto Bind';
		            action: [ self autoBind ].
	references := self newReferencesTable .
		             
	mappings := self newMrsMappingTable.
	refTitle := self newLabel
		            label: ' Unbound References ';
		            yourself.
	mapTitle := self newLabel
		            label: ' Mappings ';
		            yourself
]

{ #category : #initialization }
MoxingReferencesAndMappings >> newMrsMappingTable [

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
				 title: 'Origin';
				 evaluated: [ :each | each key name ];
				 beNotExpandable;
				 width: 50;
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: 'Mapping ';
				 evaluated: [ :each | each value printString ]);
		beMultipleSelection;
		whenSelectionChangedDo: [ :a | 
		selectedItems := a selectedItems collect: #value ].
	^ table
]

{ #category : #initialization }
MoxingReferencesAndMappings >> newReferencesTable [

	| table |
	table := self newTable
		         beMultipleSelection;
		         whenSelectionChangedDo: [ :a | 
			         selectedItems := a selectedItems collect: #value ];
		         contextMenu: [ self rootCommandsGroup asMenuPresenter ];
		         yourself.
	table
		addColumn: (SpIndexTableColumn new
				 title: 'Index';
				 sortFunction: #yourself ascending;
				 beNotExpandable;
				 width: 20;
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: '#';
				 evaluated: [ :each | each value size ];
				 beNotExpandable;
				 width: 20;
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: 'Reference';
				 evaluated: [ :each | each key asString ];
				 beNotExpandable;
				 width: 50;
				 yourself).
	^ table
]

{ #category : #'as yet unclassified' }
MoxingReferencesAndMappings >> pullUpSelectedRules [

	| source destination parents rules |
	" Is what is selected "
	rules := selectedItems.
	self assert: rules = (mappings selectedItems collect: #value).
	" We can handle batches but only from the same source.  "
	source := (mappings selectedItems collect: #key) removeDuplicates.
	self assert: source size = 1.
	source := source first.
	parents := source parents.
	destination := UIManager default
		               chooseFrom: parents
		               values: parents
		               title: 'Pull up rule'.
	destination ifNotNil: [ 
		source pullUp: rules to: destination.
		self refreshWidget ]
]

{ #category : #accessing }
MoxingReferencesAndMappings >> references: aCollection and: aFylgjaLookUpContext [

	| mapCol |
	references items: ((aCollection groupedBy: [ :a | 
			  a candidate
				  ifNil: [ a parent asString ]
				  ifNotNil: [ a candidate asString ] ]) associations sort:
			 [ :a | a key printString ] ascending).
	mapCol := aFylgjaLookUpContext allPossibleMappings .
	mappings items: mapCol.
	refTitle label:
		(' References ({1}' format: { aCollection size asString }).
	mapTitle label:
		(' Mapping Rules ({1})' format: { mapCol size asString })
]

{ #category : #accessing }
MoxingReferencesAndMappings >> refreshWidget [

	lastSelection ifNotNil: [ self updateSelectionTo: lastSelection ]
]

{ #category : #accessing }
MoxingReferencesAndMappings >> registerToController [

	self controller registerForEntitySelected: self
]

{ #category : #accessing }
MoxingReferencesAndMappings >> selectedItems [

	selectedItems ifEmpty: [ ^ {  } ].

	^ selectedItems first isCollection
		  ifTrue: [ selectedItems flatCollect: #yourself ]
		  ifFalse: [ selectedItems ]
]

{ #category : #accessing }
MoxingReferencesAndMappings >> startDraggingReference [

	^ references widget startDragging
]

{ #category : #accessing }
MoxingReferencesAndMappings >> updateSelectionTo: aSelection [
	lastSelection := aSelection. 

	self
		references: (self controller stubsFor: aSelection)
		and: (self controller mrsFor: aSelection)
]
