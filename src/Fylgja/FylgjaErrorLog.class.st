Class {
	#name : #FylgjaErrorLog,
	#superclass : #SpPresenter,
	#instVars : [
		'errors',
		'table'
	],
	#category : #'Fylgja-UI'
}

{ #category : #layout }
FylgjaErrorLog class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #table;
		  yourself
]

{ #category : #initialization }
FylgjaErrorLog >> initializePresenters [

	errors := OrderedCollection new.
	super initializePresenters.
	table := self newTable.
	table
		contextMenu: [ self rootCommandsGroup asMenuPresenter ];
		addColumn: (SpIndexTableColumn new
				 title: 'Index';
				 sortFunction: #yourself ascending;
				 beNotExpandable;
				 width: 20;
				 yourself);
		addColumn: ((SpImageTableColumn new
				  title: '';
				  evaluated: [ :each | each icon ])
				 width: 10;
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: 'Kind';
				 evaluated: [ :each | each className ];
				 beNotExpandable;
				 width: 50;
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: 'Detail';
				 evaluated: [ :each | each messageText ];
				 beExpandable;
				 yourself)
]

{ #category : #initialization }
FylgjaErrorLog >> log: anError [
 	errors add: anError. 
	table items: errors. 
]
