Class {
	#name : #FylgjaMigratorSingleDestinationUI,
	#superclass : #FylgjaAbstractUI,
	#instVars : [
		'unboundReferences',
		'lastChoice',
		'originBundle',
		'firstDestinationBundle',
		'mrsViewer',
		'toolbar',
		'version',
		'bottomControlNotebook',
		'errorLog'
	],
	#category : #'Fylgja-UI'
}

{ #category : #layout }
FylgjaMigratorSingleDestinationUI class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #toolbar;
				   add: #version width: 100;
				   yourself)
		  height: self toolbarHeight + 10;
		  add: (SpPanedLayout newTopToBottom
				   positionOfSlider: 80 percent;
				   add: (SpPanedLayout newLeftToRight
						    positionOfSlider: 50 percent;
						    add: #originBundle;
						    add: #firstDestinationBundle);
				   add: #bottomControlNotebook)
]

{ #category : #initialization }
FylgjaMigratorSingleDestinationUI >> createCheckpoint [

	self controller createCheckpointFor: self.
	self updateVersionLabel
]

{ #category : #'as yet unclassified' }
FylgjaMigratorSingleDestinationUI >> dropAllChanges [

	| anw |
	anw := UIManager default
		       questionWithoutCancel:
		       'This action cannot be undone. Are you sure to continue? '
		       title: 'DROPPING ALL CHANGES.'.
	anw := anw ifNil: [ false ].
	^ anw ifTrue: [ self controller dropAllChangesWith: self ]
]

{ #category : #'as yet unclassified' }
FylgjaMigratorSingleDestinationUI >> exportDraft [

	| directory |
	directory := UIManager default
		             chooseDirectory: 'Choose an exporting directory'
		             from: FileLocator workingDirectory.

	^ self controller exportDraft: directory informTo: self
]

{ #category : #initialization }
FylgjaMigratorSingleDestinationUI >> initializePresenters [

	super initializePresenters.
	version := self newLabel.

	toolbar := self newToolbar.
	toolbar
		addItemLeft: (self newToolbarButton
				 label: 'Create Checkpoint';
				 icon: (self iconNamed: #smallNew);
				 action: [ self createCheckpoint ]);
		addItemLeft: (self newToolbarButton
				 label: 'Rollback ';
				 icon: (self iconNamed: #smallUndo);
				 action: [ self rollback ]);
		addItemLeft: (self newToolbarButton
				 label: 'Export Draft ';
				 icon: (self iconNamed: #smallExport);
				 action: [ self exportDraft ]);
		addItemLeft: (self newToolbarButton
				 label: 'Inspect Controller  ';
				 icon: (self iconNamed: #smallInspect);
				 action: [ self controller inspect ]);
		addItemRight: (self newToolbarButton
				 label: ' Update Project';
				 icon: (self iconNamed: #edit);
				 action: [ 
					 self controller updateDestinationSourceProjectsInformTo: self ]);
		addItemRight: (self newToolbarButton
				 label: ' Undo Update Project';
				 icon: (self iconNamed: #smallUndo);
				 action: [ 
					 self controller undoUpdateDestinationSourceProjectsInformTo:
							 self ]);
		addItemRight: (self newToolbarButton
				 label: 'Save into Model ';
				 icon: (self iconNamed: #smallSave);
				 action: [ 
					 self controller
						 logWarning: 'Save into model is not yet implemented '
						 operation: #Save ]);
		addItemRight: (self newToolbarButton
				 label: 'Drop All Changes ';
				 icon: (self iconNamed: #halt);
				 action: [ self dropAllChanges ]).



	originBundle := self newAccessMoxingBundle.
	firstDestinationBundle := self newMoxingBundle.



	originBundle := self newAccessMoxingBundle.
	firstDestinationBundle := self newMoxingBundle.
	errorLog :=  self instantiate: FylgjaLoggingWidget.
	bottomControlNotebook := self newNotebook.


	mrsViewer := self instantiate: FylgjaMRSViewer.
	unboundReferences := self instantiate: MoxingReferencesAndMappings.
	bottomControlNotebook addPageTitle:'Log' provider: [ errorLog ].
	bottomControlNotebook
		addPageTitle: 'Produce & Delegate'
		provider: [ mrsViewer ].
	bottomControlNotebook
		addPageTitle: 'Binding & References'
		provider: [ unboundReferences ].
	originBundle modelAccessor: #origin.
	firstDestinationBundle modelAccessor: [ :controller | 
		controller destinations first ]
]

{ #category : #initialization }
FylgjaMigratorSingleDestinationUI >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	self updateVersionLabel
]

{ #category : #initialization }
FylgjaMigratorSingleDestinationUI >> installRuleOn: anEntity [ 

	self halt 
]

{ #category : #initialization }
FylgjaMigratorSingleDestinationUI >> manageTransfer: aTransfer for: aWidget [

	^ (UIManager default
		   chooseFrom: #( Produce Map )
		   values: { 
				   [ self produceUsing: aTransfer for: aWidget ].
				   [ self mapUsing: aTransfer for: aWidget ] }
		   title: 'Fylgja') ifNotNil: [ :block | block value ]
]

{ #category : #initialization }
FylgjaMigratorSingleDestinationUI >> mapUsing: aTransfer for: aWidget [

	| contexts context |
	contexts := aTransfer target parents.
	context := UIManager default
		           chooseFrom: (contexts collect: [ :c | 
				            c name , String tab , '(' , c anchor printString , ')' ])
		           values: contexts
		           title: 'Context of validity'.
	context ifNil: [ ^ self ].
	aTransfer passenger do: [ :first | 
		self controller
			map: first
			to: aTransfer target
			context: context
			informing: aWidget ]
]

{ #category : #initialization }
FylgjaMigratorSingleDestinationUI >> newAccessMoxingBundle [

	^ (self instantiate: MoxingBundle)
		  shouldInformSelection: false;
		  yourself
]

{ #category : #initialization }
FylgjaMigratorSingleDestinationUI >> newMoxingBundle [

	^ (self instantiate: MoxingBundle)
		  whenTransferring: [ :transfer :widget | 
			  self manageTransfer: transfer for: widget.
			  widget resetCode: transfer target ];
		  yourself
]

{ #category : #initialization }
FylgjaMigratorSingleDestinationUI >> produceUsing: aTransfer for: aWidget [

	| rules title |
	rules := aTransfer passenger collect: [ :first | 
		         self controller
			         lookupAllRulesForProducing: first
			         toContext: aTransfer target ].

	title := aTransfer passenger collect: [ :first | 
		         first printString , ' Into: '
		         , aTransfer target printString ].

	aWidget
		promptUser: title
		forChosingRule: rules
		for: aTransfer passenger
		thenDo: [ :rule :model :element | 
			self controller
				produce: element
				applying: rule
				into: (model entityFor: aTransfer target)
				informing: aWidget ]
]

{ #category : #initialization }
FylgjaMigratorSingleDestinationUI >> rollback [

	self controller rollbackFor: self.
	self updateVersionLabel
]

{ #category : #initialization }
FylgjaMigratorSingleDestinationUI >> ruleHasBeenAppliedSuccessfully [

	" Should be refreshing all "

	originBundle ruleHasBeenAppliedSuccessfully.
	firstDestinationBundle ruleHasBeenAppliedSuccessfully.


	self updateVersionLabel
]

{ #category : #initialization }
FylgjaMigratorSingleDestinationUI >> updateVersionLabel [

	self withWindowDo: [ :window | 
		window title: ('{1} Version: {2}' format: { 
					 self controller projectName.
					 self controller versionNumber }) ]
]
