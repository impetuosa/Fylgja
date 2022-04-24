Class {
	#name : #MoxingTree,
	#superclass : #SpPresenter,
	#instVars : [
		'tree'
	],
	#category : #'Fylgja-UI'
}

{ #category : #layout }
MoxingTree class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #tree;
		  yourself
]

{ #category : #initialization }
MoxingTree >> childrenFor: anEntry [

	| entity |
	entity := anEntry isAssociation
		          ifTrue: [ anEntry value ]
		          ifFalse: [ anEntry ].
	entity isCollection ifTrue: [ ^ {  } ].
	^ (entity isKindOf: MOModel)
		  ifTrue: [ { entity root } ]
		  ifFalse: [ entity allContainments reject: [ :a | a isKindOf: MOEmptyBlock  ] ]
]

{ #category : #initialization }
MoxingTree >> iconFor: anEntry [

	^ (anEntry isKindOf: Association)
		  ifTrue: [ MoxingIcons iconForEntryName: anEntry key ]
		  ifFalse: [ MoxingIcons iconFor: anEntry ]
]

{ #category : #initialization }
MoxingTree >> imageRepresentationFor: each [

	^ (MOElementToUIString new toString: each) asStringMorph
]

{ #category : #initialization }
MoxingTree >> initializePresenters [

	super initializePresenters.

	tree := self newTreeTable.
	tree dragEnabled: true.
	tree dropEnabled: true.
	tree
		wantsDrop: [ :transfer | 
			transfer passenger allSatisfy: #isDeclaration ];
		acceptDrop: [ :transfer | 
			tree items: tree items , transfer passenger ].
	tree
		addColumn: (SpCompositeTableColumn new
				 title: '';
				 addColumn:
					 ((SpImageTableColumn evaluated: [ :each | self iconFor: each ])
						  width: 20;
						  yourself);
				 addColumn: (SpImageTableColumn evaluated: [ :each | 
						  self imageRepresentationFor: each ]);
				 yourself);
		children: [ :entry | self childrenFor: entry ]
]

{ #category : #initialization }
MoxingTree >> selectEntity: anEntity [

	tree items: (self childrenFor: anEntity)
]

{ #category : #enumerating }
MoxingTree >> whenSelectionChangedDo: aFullBlockClosure [

	^ tree whenSelectionChangedDo: aFullBlockClosure
]
