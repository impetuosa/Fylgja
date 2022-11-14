Class {
	#name : #MoxingMapping,
	#superclass : #FylgjaAbstractUI,
	#instVars : [
		'source',
		'target',
		'sourceList',
		'expressionButton',
		'targetList',
		'mapping'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #layout }
MoxingMapping class >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  add: (SpBoxLayout newTopToBottom
				   add: #sourceList;
				   add: #expressionButton height: self toolbarHeight ;
				   yourself);
		  add: #targetList;
		  yourself
]

{ #category : #initialization }
MoxingMapping >> iconFor: anEntry [

	^ (anEntry isKindOf: Association)
		  ifTrue: [ MoxingIcons iconForEntryName: anEntry key ]
		  ifFalse: [ MoxingIcons iconFor: anEntry ]
]

{ #category : #initialization }
MoxingMapping >> imageRepresentationFor: each [

	^ (MOElementToUIString new toString: each) asStringMorph
]

{ #category : #initialization }
MoxingMapping >> initializePresenters [

	super initializePresenters.
	sourceList := self newTable.
	sourceList dragEnabled: true.

	targetList := self newTable.
	targetList dropEnabled: true.


	sourceList addColumn: (SpCompositeTableColumn new
			 title: 'Source';
			 addColumn:
				 ((SpImageTableColumn evaluated: [ :each | self iconFor: each ])
					  width: 20;
					  yourself);
			 addColumn: (SpImageTableColumn evaluated: [ :each | 
					  self imageRepresentationFor: each ]);
			 yourself).
	targetList
		addColumn: (SpImageTableColumn
				 title: 'Mapped'
				 evaluated: [ :each | 
					 self imageRepresentationFor: (self mapFor: each) ]);
		addColumn: (SpCompositeTableColumn new
				 title: 'Target';
				 addColumn:
					 ((SpImageTableColumn evaluated: [ :each | self iconFor: each ])
						  width: 20;
						  yourself);
				 addColumn: ((SpImageTableColumn evaluated: [ :each | 
							   self imageRepresentationFor: each ])
						  width: 100;
						  yourself);
				 yourself);
		wantsDrop: [ :transfer | 
			transfer passenger isNotNil and: [ 
				transfer passenger size = 1 and: [ 
					transfer passenger first parent = source ] ] ];
		acceptDrop: [ :transfer | self manageTransfer: transfer ].


	expressionButton := self newButton.
	expressionButton label: '+ Expression'
]

{ #category : #initialization }
MoxingMapping >> manageTransfer: aTransfer [

	mapping
		at: (targetList items at: aTransfer row)
		put: aTransfer passenger first
]

{ #category : #initialization }
MoxingMapping >> mapFor: anObject [

	^ mapping at: anObject ifAbsent: [ '' ]
]

{ #category : #initialization }
MoxingMapping >> mapping [

	^ mapping
]

{ #category : #initialization }
MoxingMapping >> openModal [

	| dialog |
	dialog := super openModal.
	^ dialog isOk
]

{ #category : #initialization }
MoxingMapping >> setTitle [

	self withWindowDo: [ :window | 
		window title: ('Mapping {1} to {2}' format: { 
					 (MOElementToUIString new toString: source).
					 (MOElementToUIString new toString: target) }) ]
]

{ #category : #initialization }
MoxingMapping >> source: aSource target: aTarget [

	mapping := Dictionary new.
	source := aSource.
	target := aTarget.
	sourceList items: (source allContainments select: #isDeclaration).
	targetList items: (target allContainments select: #isDeclaration).
	self setTitle
]
