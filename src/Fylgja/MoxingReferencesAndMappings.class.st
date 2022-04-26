Class {
	#name : #MoxingReferencesAndMappings,
	#superclass : #SpPresenter,
	#instVars : [
		'references',
		'fylUi',
		'autoBind',
		'mappings',
		'refTitle',
		'mapTitle',
		'selectedItems'
	],
	#category : #'Fylgja-UI'
}

{ #category : #layout }
MoxingReferencesAndMappings class >> buildCommandsGroupWith: presenterInstance forRoot: rootCommandGroup [

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

{ #category : #accessing }
MoxingReferencesAndMappings >> autoBind [

	^ fylUi autoBind: references items
]

{ #category : #'as yet unclassified' }
MoxingReferencesAndMappings >> autoBindSelection [

	fylUi autoBind: references selectedItems
]

{ #category : #accessing }
MoxingReferencesAndMappings >> fylUi: aFylUI [

	fylUi := aFylUI
]

{ #category : #initialization }
MoxingReferencesAndMappings >> initializePresenters [

	super initializePresenters.
	autoBind := self newButton
		            label: 'Auto Bind';
		            action: [ self autoBind ].
	references := self newTable
		              beMultipleSelection;
		              whenSelectionChangedDo: [ :a | 
			              selectedItems := a selectedItems collect: #value ];
		              contextMenu: [ self rootCommandsGroup asMenuPresenter ];
		              yourself.
	mappings := self newMrsTable.
	refTitle := self newLabel
		            label: ' References ';
		            yourself.
	mapTitle := self newLabel
		            label: ' Mapping Rules ';
		            yourself
]

{ #category : #initialization }
MoxingReferencesAndMappings >> newMrsTable [

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
		beMultipleSelection;
		whenSelectionChangedDo: [ :a | 
		selectedItems := a selectedItems collect: #value ].
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
	destination ifNotNil: [ source pullUp: rules to: destination ]
]

{ #category : #accessing }
MoxingReferencesAndMappings >> references: aCollection and: aFylgjaLookUpContext [

	| mapCol |
	references items: (aCollection sort: #printString descending).
	mapCol := aFylgjaLookUpContext allPossibleMappingRules.
	mappings items: mapCol.
	refTitle label:
		(' References ({1}' format: { aCollection size asString }).
	mapTitle label:
		(' Mapping Rules ({1})' format: { mapCol size asString })
]

{ #category : #accessing }
MoxingReferencesAndMappings >> selectedItems [
	^ selectedItems
]
