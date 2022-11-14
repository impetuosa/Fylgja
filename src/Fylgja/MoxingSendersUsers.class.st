Class {
	#name : #MoxingSendersUsers,
	#superclass : #SpPresenter,
	#instVars : [
		'table'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #layout }
MoxingSendersUsers class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #table;
		  yourself
]

{ #category : #initialization }
MoxingSendersUsers >> initializePresenters [

	super initializePresenters.
	table := self newTable.
	table
		contextMenu: [ self rootCommandsGroup asMenuPresenter ];
		addColumn: (SpStringTableColumn new
				 title: 'Project';
				 evaluated: [ :each | each enclosingArtefact name ];
				 beNotExpandable;
				 width: 20;
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: 'Type';
				 evaluated: [ :each | each enclosingTypeOrModule name ];
				 beNotExpandable;
				 width: 50;
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: 'Signature';
				 evaluated: [ :each | MOElementToUIString new toString: each ];
				 beNotExpandable;
				 width: 50;
				 yourself)
]

{ #category : #initialization }
MoxingSendersUsers >> usersOrSenders: aCollection [

	table items: (aCollection reject: #isNil)
]
