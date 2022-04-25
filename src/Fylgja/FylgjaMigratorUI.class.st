Class {
	#name : #FylgjaMigratorUI,
	#superclass : #FylgjaAbstractMigratorUI,
	#instVars : [
		'mrs',
		'errorLog',
		'unboundReferences',
		'control',
		'accessBundle',
		'javaBundle',
		'tsBundle'
	],
	#category : #'Fylgja-UI'
}

{ #category : #layout }
FylgjaMigratorUI class >> defaultLayout [

	^ SpPanedLayout newTopToBottom
		  positionOfSlider: 80 percent;
		  add: (SpPanedLayout newLeftToRight
				   positionOfSlider: 50 percent;
				   add: (SpPanedLayout newTopToBottom
						    positionOfSlider: 70 percent;
						    add: #access;
						    add: #control);
				   add: (SpPanedLayout newTopToBottom
						    positionOfSlider: 50 percent;
						    add: #java;
						    add: #ts));
		  add: #errorLog
]

{ #category : #initialization }
FylgjaMigratorUI >> initializePresenters [

	super initializePresenters.
	accessBundle := self newMoxingBundle.
	javaBundle := self newMoxingBundle.
	tsBundle := self newMoxingBundle.  .
	control := self newNotebook.
	errorLog := self newTreeTable.


	mrs := self instantiate: FylgjaMRSViewer.
	unboundReferences := self instantiate: MoxingUnboundReferences.
	control addPageTitle: 'MRS' provider: [ mrs ].
	control addPageTitle: 'References' provider: [ unboundReferences ]
]

{ #category : #initialization }
FylgjaMigratorUI >> installRuleOn: anEntity [ 

	self halt 
]

{ #category : #initialization }
FylgjaMigratorUI >> manageTransfer: aTransfer [
 	self halt 
]

{ #category : #initialization }
FylgjaMigratorUI >> newMoxingBundle [

	^ (self instantiate: MoxingBundle)
		  fylUi: self;
		  whenSelectionChangedDo: [ :a | self showMrs: a ];
		  whenTransferring: [ :transfer | self manageTransfer: transfer ];
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaMigratorUI >> openNorthwind [

	super openNorthwind.
	accessBundle model: (fylgja derivativeModelFor: northwind).
	javaBundle model: (fylgja derivativeModelFor: java).
	tsBundle model: (fylgja derivativeModelFor: angular)
]

{ #category : #'as yet unclassified' }
FylgjaMigratorUI >> showMrs: aMORootDeclaration [

	mrs model: (fylgja lookUpContext: aMORootDeclaration)
]
