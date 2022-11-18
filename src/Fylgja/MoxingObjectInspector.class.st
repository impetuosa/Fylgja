Class {
	#name : #MoxingObjectInspector,
	#superclass : #SpPresenter,
	#instVars : [
		'list',
		'model',
		'name',
		'type'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #layout }
MoxingObjectInspector class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #name;
				   add: #type)
		  height: self toolbarHeight;
		  add: #list;
		  yourself
]

{ #category : #initialization }
MoxingObjectInspector >> initializePresenters [

	super initializePresenters.
	list := self instantiate: SpMillerColumnPresenter.
	list presenterBlock: [ :nid | self newPresenterFor: nid ].
	name := self newLabel.
	type := self newLabel
]

{ #category : #accessing }
MoxingObjectInspector >> model: aMOObject [

	model := aMOObject.
	list setRootModel: model
]

{ #category : #initialization }
MoxingObjectInspector >> newPresenterFor: aModel [

	| table |
	aModel value isMOObject ifFalse: [ ^ self newTable ].

	table := self newTable.
	table
		contextMenu: [ self rootCommandsGroup asMenuPresenter ];
		addColumn: (SpStringTableColumn new
				 title: 'Name';
				 evaluated: [ :each | each key ];
				 beNotExpandable;
				 width: 20;
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: 'Value';
				 evaluated: [ :each | 
					 each value isMOObject
						 ifTrue: [ each value name ]
						 ifFalse: [ each value asString ] ];
				 beNotExpandable;
				 width: 50;
				 yourself);
		whenSelectedDo: [ :item | self selectedItem: item value ].

	(aModel isKindOf: Association)
		ifTrue: [ table items: aModel value state associations ]
		ifFalse: [ table items: aModel state associations ].
	^ table
]

{ #category : #initialization }
MoxingObjectInspector >> selectedItem: anItem [

	anItem isMOObject
		ifTrue: [ 
			name label: anItem name.
			type label: anItem type name ]
		ifFalse: [ 
			name label: '-'.
			type label: '-' ]
]
