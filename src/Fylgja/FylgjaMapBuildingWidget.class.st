Class {
	#name : #FylgjaMapBuildingWidget,
	#superclass : #SpPresenter,
	#instVars : [
		'objectToMap',
		'mapping',
		'destinations',
		'ok',
		'cancel'
	],
	#category : #'Fylgja-Widget'
}

{ #category : #specs }
FylgjaMapBuildingWidget class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: #mapping height: self toolbarHeight ;
		  add: #destinations;
		  add: (SpBoxLayout newLeftToRight
				   add: #ok;
				   add: #cancel;
				   yourself) height: self toolbarHeight ;
		  yourself
]

{ #category : #initialization }
FylgjaMapBuildingWidget >> bind [


]

{ #category : #accessing }
FylgjaMapBuildingWidget >> fylgja: aFylModel [

	fylgja := aFylModel.
	fylgja destinations do: [ :d | 
		| page |
		page := self
			        newNotebookPage
			        title: d name;
			        presenterProvider: (self treeTableFor: d);
			        yourself.
		destinations addPage: page ]
]

{ #category : #'as yet unclassified' }
FylgjaMapBuildingWidget >> initializePresenters [

	super initializePresenters.
	mapping := self newLabel.
	destinations := self newNotebook.
	ok := self newButton
		      label: #OK;
		      action: [ self map ].
	cancel := self newButton
		          label: #Cancel;
		          action: [ self withWindowDo: [ :w | w close ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMapBuildingWidget >> objectToMap: anAlcixPrimitiveType [

	objectToMap := anAlcixPrimitiveType.
	mapping label: objectToMap name , ' : ' , objectToMap className
]

{ #category : #accessing }
FylgjaMapBuildingWidget >> treeTableFor: aMoProject [

	^ MOProjectTree newFor: aMoProject
]
