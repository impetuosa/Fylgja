Class {
	#name : #MoxingCode,
	#superclass : #FylgjaAbstractUI,
	#instVars : [
		'pagesObjectsMap',
		'viewport'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #layout }
MoxingCode class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #viewport;
		  yourself
]

{ #category : #initialization }
MoxingCode >> codeFor: aCodeObject [

	^ pagesObjectsMap at: aCodeObject ifAbsentPut: [ 
		  MoxingTextComposer new
			  compose: (self controller produceCode: aCodeObject)
			  parser: aCodeObject language parser
			  model: aCodeObject
			  style: aCodeObject language style
			  browsingWith: self ]
]

{ #category : #initialization }
MoxingCode >> iconFor: anEntry [

	^ MoxingIcons iconFor: anEntry
]

{ #category : #initialization }
MoxingCode >> initializePresenters [
	super initializePresenters.
	pagesObjectsMap := Dictionary new.
	viewport := self newNotebook.
	viewport whenPageRemovedDo: [ :p | 
		pagesObjectsMap removeKey: p ifAbsent: [  ] ].
	viewport whenPagesChangedDo: [ :p | 
		pagesObjectsMap at: p ifPresent: [ :m | self selectEntity: m ] ]
]

{ #category : #initialization }
MoxingCode >> newNotebookPageFor: aModule [
	^  self newNotebookPage 
]

{ #category : #initialization }
MoxingCode >> resetCode: anObject [

	pagesObjectsMap removeKey: anObject ifAbsent: [  ]
]

{ #category : #initialization }
MoxingCode >> visualizeSourcecode: aCodeObject [

	| text page |
	text := self newText.

	page := (self newNotebookPageFor: aCodeObject)
		        title: aCodeObject anchor printString;
		        presenterProvider: text;
		        icon: (self iconFor: aCodeObject);
		        beCloseable.


	viewport pages: { page }.
	viewport selectPage: page.

	text text: (self codeFor: aCodeObject)
]
