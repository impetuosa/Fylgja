Class {
	#name : #FylgjaLoggingWidget,
	#superclass : #FylgjaAbstractUI,
	#instVars : [
		'table',
		'logs'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #layout }
FylgjaLoggingWidget class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #table;
		  yourself
]

{ #category : #initialization }
FylgjaLoggingWidget >> initializePresenters [

	logs := OrderedCollection new.
	super initializePresenters.
	table := self newTable.
	table
		contextMenu: [ self rootCommandsGroup asMenuPresenter ];
		addColumn: (SpStringTableColumn new
				 title: 'Stamp';
				 sortFunction: #yourself descending;
				 evaluated: [ :each | self stringStamp: each stamp ];
				 width: 20;
				 yourself);
		addColumn: ((SpImageTableColumn new
				  title: '';
				  evaluated: [ :each | each icon ])
				 width: 10;
				 yourself);
		addColumn: (SpStringTableColumn new
				 title: 'Operation';
				 evaluated: [ :each | each operation ];
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
FylgjaLoggingWidget >> log: aLog [
 	logs add: aLog. 
	table items: logs. 
]

{ #category : #initialization }
FylgjaLoggingWidget >> registerToController [

	self controller registerForEventLogging: self
]

{ #category : #initialization }
FylgjaLoggingWidget >> stringStamp: stamp [

	^ String streamContents: [ :s | 
		  stamp printYMDOn: s.
		  s nextPutAll: ' '.
		  stamp printHMSOn: s separatedBy: $: ]
]
