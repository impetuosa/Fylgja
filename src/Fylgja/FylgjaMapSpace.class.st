Class {
	#name : #FylgjaMapSpace,
	#superclass : #Object,
	#instVars : [
		'entries',
		'parent',
		'friends',
		'name'
	],
	#category : #'Fylgja-Model'
}

{ #category : #public }
FylgjaMapSpace >> get: anAlcixFunction [

	^ entries at: anAlcixFunction ifAbsent: [ 
		  NotFound signal:
			  'Cannotfind a suitable mapping entity for '
			  , anAlcixFunction asString ]
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> initialize [ 
	 super initialize.
	entries := Dictionary new. 
	friends := Set new. 
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> mapspaceFor: aMOAnchor [

	^ aMOAnchor names
		  inject: self
		  into: [ :space :entry | 
		  space mapspaceForName: entry ifAbsent: [ ^ space ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> mapspaceForName: aString ifAbsent: aFullBlockClosure [

	^ entries at: aString ifAbsent: [ aFullBlockClosure value ]
]

{ #category : #accessing }
FylgjaMapSpace >> name: aString [

	name := aString
]

{ #category : #accessing }
FylgjaMapSpace >> parent: aFylgjaMapSpace [ 
	parent := aFylgjaMapSpace
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> registerSpace: aName [

	entries at: aName ifPresent: [ self halt ].
	entries at: aName put: (FylgjaMapSpace new
			 name: aName;
			 parent: self;
			 yourself)
]
