Class {
	#name : #FylgjaMigratorUI,
	#superclass : #FylgjaAbstractUI,
	#instVars : [
		'errorLog',
		'unboundReferences',
		'lastChoice',
		'originBundle',
		'firstDestinationBundle',
		'secondDestinationBundle',
		'controlNotebook',
		'mrsViewer',
		'toolbar',
		'version'
	],
	#category : #'Fylgja-UI'
}

{ #category : #layout }
FylgjaMigratorUI class >> defaultLayout [

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
						    add: (SpPanedLayout newTopToBottom
								     positionOfSlider: 70 percent;
								     add: #originBundle;
								     add: #controlNotebook);
						    add: (SpPanedLayout newTopToBottom
								     positionOfSlider: 50 percent;
								     add: #firstDestinationBundle;
								     add: #secondDestinationBundle));
				   add: #errorLog)
]

{ #category : #initialization }
FylgjaMigratorUI >> createCheckpoint [

	self controller createCheckpointFor: self.
	self updateVersionLabel
]

{ #category : #'as yet unclassified' }
FylgjaMigratorUI >> dropAllChanges [

	| anw |
	anw := UIManager default
		       questionWithoutCancel:
		       'This action cannot be undone. Are you sure to continue? '
		       title: 'DROPPING ALL CHANGES.'.
	anw := anw ifNil: [ false ].
	^ anw ifTrue: [ self controller dropAllChangesWith: self ]
]

{ #category : #'as yet unclassified' }
FylgjaMigratorUI >> exportDraft [

	| directory |
	directory := UIManager default
		             chooseDirectory: 'Choose an exporting directory'
		             from: FileLocator workingDirectory.

	^ self controller exportDraft: directory informTo: self
]

{ #category : #initialization }
FylgjaMigratorUI >> initializePresenters [

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
	secondDestinationBundle := self newMoxingBundle.
	controlNotebook := self newNotebook.



	originBundle := self newAccessMoxingBundle.
	firstDestinationBundle := self newMoxingBundle.
	secondDestinationBundle := self newMoxingBundle.
	controlNotebook := self newNotebook.
	errorLog := self instantiate: FylgjaLoggingWidget.


	mrsViewer := self instantiate: FylgjaMRSViewer.
	unboundReferences := self instantiate: MoxingReferencesAndMappings.

	controlNotebook
		addPageTitle: 'Produce & Delegate'
		provider: [ mrsViewer ].
	controlNotebook
		addPageTitle: 'Binding & References'
		provider: [ unboundReferences ].
	originBundle modelAccessor: #origin.
	firstDestinationBundle modelAccessor: [ :controller | 
		controller destinations first ].
	secondDestinationBundle modelAccessor: [ :controller | 
		controller destinations second ]
]

{ #category : #initialization }
FylgjaMigratorUI >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	self updateVersionLabel
]

{ #category : #initialization }
FylgjaMigratorUI >> installRuleOn: anEntity [ 

	self halt 
]

{ #category : #initialization }
FylgjaMigratorUI >> manageTransfer: aTransfer for: aWidget [

	^ (UIManager default
		   chooseFrom: #( Produce Map )
		   values: { 
				   [ self produceUsing: aTransfer for: aWidget ].
				   [ self mapUsing: aTransfer for: aWidget ] }
		   title: 'Fylgja') ifNotNil: [ :block | block value ]
]

{ #category : #initialization }
FylgjaMigratorUI >> mapUsing: aTransfer for: aWidget [

	| contexts context |
	contexts := aTransfer target parents.
	context := UIManager default
		           chooseFrom: (contexts collect: [ :c | 
				            c name , String tab , '(' , c anchor printString , ')' ])
		           values: contexts
		           title: 'Context of validity'.
	context ifNil: [ ^ self ].
	self controller
		map: aTransfer passenger first
		to: aTransfer target
		context: context
		informing: aWidget
]

{ #category : #initialization }
FylgjaMigratorUI >> newAccessMoxingBundle [

	^ (self instantiate: MoxingBundle)
		  shouldInformSelection: false;
		  yourself
]

{ #category : #initialization }
FylgjaMigratorUI >> newMoxingBundle [

	^ (self instantiate: MoxingBundle)
		  whenTransferring: [ :transfer : widget | self manageTransfer: transfer for: widget ];
		  yourself
]

{ #category : #initialization }
FylgjaMigratorUI >> produceUsing: aTransfer for: aWidget [

	| produced |
	produced := self controller
		            produce: aTransfer passenger first
		            into: aTransfer target
		            informing: aWidget
]

{ #category : #initialization }
FylgjaMigratorUI >> rollback [

	self controller rollbackFor: self.
	self updateVersionLabel
]

{ #category : #initialization }
FylgjaMigratorUI >> ruleHasBeenAppliedSuccessfully [

	" Should be refreshing all "

	originBundle ruleHasBeenAppliedSuccessfully.
	firstDestinationBundle ruleHasBeenAppliedSuccessfully.
	secondDestinationBundle ruleHasBeenAppliedSuccessfully.

	self updateVersionLabel
]

{ #category : #initialization }
FylgjaMigratorUI >> updateVersionLabel [

	self withWindowDo: [ :window | 
		window title: ('{1} Version: {2}' format: { 
					 self controller projectName.
					 self controller versionNumber }) ]
]
