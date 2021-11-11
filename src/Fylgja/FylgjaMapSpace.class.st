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

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> initialize [ 
	 super initialize.
	entries := Dictionary new. 
	friends := Set new. 
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> mapspaceFor: aMOAnchor [ 
	self shouldBeImplemented.
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
