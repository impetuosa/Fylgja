Class {
	#name : #FylgjaCommands,
	#superclass : #CmCommand,
	#category : #'Fylgja-Commands'
}

{ #category : #'as yet unclassified' }
FylgjaCommands >> fylgja [

	^ self mooseModel fylgja
]

{ #category : #'operators-mapping' }
FylgjaCommands >> map: anEntity [

	FylgjaMapBuildingWidget new
		fylgja: self fylgja;
		objectToMap: context selectedItem;
		openWithSpec
]

{ #category : #'as yet unclassified' }
FylgjaCommands >> mooseModel [

	^ context selectedItem mooseModel
]
