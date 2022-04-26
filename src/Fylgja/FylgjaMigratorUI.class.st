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
		'tsBundle',
		'lastChoice'
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
						    add: #accessBundle;
						    add: #control);
				   add: (SpPanedLayout newTopToBottom
						    positionOfSlider: 50 percent;
						    add: #javaBundle;
						    add: #tsBundle));
		  add: #errorLog
]

{ #category : #initialization }
FylgjaMigratorUI >> autoBind [

	self halt.
	fylgja forceMap.
	self refreshWidgets
]

{ #category : #'as yet unclassified' }
FylgjaMigratorUI >> autoBind: aCollection [

	fylgja forceMapReferences: aCollection
]

{ #category : #'as yet unclassified' }
FylgjaMigratorUI >> doOrLog: aFullBlockClosure [

	^ [ 
	  aFullBlockClosure value.
	  true ]
		  on: Error
		  do: [ :e | 
			  self logError: e.
			  false.
			  e pass ]
]

{ #category : #initialization }
FylgjaMigratorUI >> initializePresenters [

	super initializePresenters.
	accessBundle := self newAccessMoxingBundle.
	javaBundle := self newMoxingBundle.
	tsBundle := self newMoxingBundle.
	control := self newNotebook.
	errorLog := self instantiate: FylgjaErrorLog.


	mrs := self instantiate: FylgjaMRSViewer.
	unboundReferences := self instantiate: MoxingReferencesAndMappings.
	unboundReferences fylUi: self .
	control addPageTitle: 'Produce & Delegate' provider: [ mrs ].
	control addPageTitle: 'Binding & References' provider: [ unboundReferences ]
]

{ #category : #initialization }
FylgjaMigratorUI >> installRuleOn: anEntity [ 

	self halt 
]

{ #category : #initialization }
FylgjaMigratorUI >> logError: anError [

	errorLog log: anError
]

{ #category : #initialization }
FylgjaMigratorUI >> manageTransfer: aTransfer [

	| prov dest |
	prov := aTransfer passenger first.
	dest := aTransfer target.

	^ self doOrLog: [ 
		  self
			  assert: prov isNotNil
			  description: ' Cannot resolve provenance entity .'.
		  self
			  assert: prov isNotNil
			  description: ' Cannot resolve destination .'.
		  (UIManager default
			   chooseFrom: #( Produce Map )
			   values: { 
					   [ self produceUsing: aTransfer ].
					   [ self mapUsing: aTransfer ] }
			   title: 'Fylgja') ifNotNil: [ :block | block value ] ]
]

{ #category : #initialization }
FylgjaMigratorUI >> mapUsing: aTransfer [

	| contexts context |
	contexts := aTransfer target parents.
	context := UIManager default
		           chooseFrom:
		           (contexts collect: [ :c | 
			            c name , String tab, '(' , c anchor printString , ')' ])
		           values: contexts
		           title: 'Context of validity'.
	context ifNil: [ ^ self ].
	fylgja
		map: aTransfer passenger first
		to: aTransfer target
		context: context.


	self logError: (Notification new
			 messageText:
				 aTransfer passenger first printString , '  mapped to  '
				 , aTransfer target printString;
			 yourself)
]

{ #category : #initialization }
FylgjaMigratorUI >> newAccessMoxingBundle [

	^ (self instantiate: MoxingBundle)
		  fylUi: self;
		  yourself
]

{ #category : #initialization }
FylgjaMigratorUI >> newMoxingBundle [

	^ (self instantiate: MoxingBundle)
		  fylUi: self;
		  whenSelectionChangedDo: [ :a | self updateWidgets: a ];
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

{ #category : #initialization }
FylgjaMigratorUI >> produceUsing: aTransfer [

	| produced |
	produced := fylgja
		            produce: aTransfer passenger first
		            into: aTransfer target.
	self logError: (Notification new
			 messageText: produced realResult printString , '  produced ';
			 yourself)
]

{ #category : #'as yet unclassified' }
FylgjaMigratorUI >> refreshWidgets [

	lastChoice ifNotNil: [ self updateWidgets: lastChoice ]
]

{ #category : #'as yet unclassified' }
FylgjaMigratorUI >> stubsFor: aMORootDeclaration [

	^ FylgjaReachableStubs new stubsFor: aMORootDeclaration
]

{ #category : #'as yet unclassified' }
FylgjaMigratorUI >> updateWidgets: aMORootDeclaration [

	| lookup |
	lastChoice := aMORootDeclaration.
	lookup := fylgja lookUpContext: aMORootDeclaration.
	mrs model: lookup.
	unboundReferences
		references: (self stubsFor: aMORootDeclaration)
		and: lookup
]
