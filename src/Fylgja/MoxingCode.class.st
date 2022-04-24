Class {
	#name : #MoxingCode,
	#superclass : #SpPresenter,
	#instVars : [
		'pagesObjectsMap',
		'viewport'
	],
	#category : #'Fylgja-UI'
}

{ #category : #layout }
MoxingCode class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #viewport;
		  yourself
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

	| p |
	p := self newNotebookPage.
	pagesObjectsMap at: p put: aModule.
	^ p
]

{ #category : #initialization }
MoxingCode >> visualizeSourcecode: aCodeObject [

	| text page |
	viewport pages
		detect: [ :p | p title = aCodeObject name ]
		ifFound: [ :p | 
			viewport selectPage: p.
			^ p ].

	text := self newText.

	page := (self newNotebookPageFor: aCodeObject)
		        title: aCodeObject name;
		        presenterProvider: text;
		        icon: (self iconFor: aCodeObject);
		        beCloseable.


	viewport pages: { page }.
	viewport selectPage: page.

	text text: (MoxingTextComposer new
			 compose: aCodeObject produceCode
			 parser: aCodeObject language parser
			 model: aCodeObject
			 style: aCodeObject language style
			 browsingWith: self)
]
