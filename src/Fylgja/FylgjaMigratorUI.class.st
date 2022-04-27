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
		'mrsViewer'
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
						    add: #originBundle;
						    add: #controlNotebook);
				   add: (SpPanedLayout newTopToBottom
						    positionOfSlider: 50 percent;
						    add: #firstDestinationBundle;
						    add: #secondDestinationBundle));
		  add: #errorLog
]

{ #category : #initialization }
FylgjaMigratorUI >> initializePresenters [

	super initializePresenters.
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
	originBundle model: self controller origin.
	firstDestinationBundle model: self controller destinations first.
	secondDestinationBundle model: self controller destinations second
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

{ #category : #'as yet unclassified' }
FylgjaMigratorUI >> refreshWidgets [

	lastChoice ifNotNil: [ self updateWidgets: lastChoice ]
]

{ #category : #'as yet unclassified' }
FylgjaMigratorUI >> updateWidgets: aMORootDeclaration [

	| lookup |
	lastChoice := aMORootDeclaration.
	lookup := self controller mrsFor: aMORootDeclaration.
	mrsViewer model: lookup.
	unboundReferences
		references: (self controller stubsFor: aMORootDeclaration)
		and: lookup
]
