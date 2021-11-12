Class {
	#name : #FylgjaMapSpace,
	#superclass : #Object,
	#instVars : [
		'parent',
		'friends',
		'name',
		'mappings',
		'producers'
	],
	#category : #'Fylgja-Model'
}

{ #category : #public }
FylgjaMapSpace >> get: anAlcixFunction [

	^ self get: anAlcixFunction ifAbsent: [ 
		  NotFound signal:
			  'Cannotfind a suitable mapping entity for '
			  , anAlcixFunction asString ]
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> get: anAlcixFunction ifAbsent: aFullBlockClosure [

	^ mappings at: anAlcixFunction ifAbsent: [ aFullBlockClosure value ]
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> getOrCreateMapspaceFor: aMOAnchor [

	^ aMOAnchor names inject: self into: [ :space :entry | 
		  space
			  mapspaceForName: entry
			  ifAbsent: [ space registerSpace: entry ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> initialize [ 
	 super initialize.
	mappings := Dictionary new. 
	producers := Dictionary new.
	friends := Set new. 
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> installProducer: aFylgjaTranslator from: anAlcixFunction [

	producers at: anAlcixFunction put: aFylgjaTranslator
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

	^ mappings at: aString ifAbsent: [ aFullBlockClosure value ]
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
FylgjaMapSpace >> producerFor: anAlcixFunction [

	^ producers at: anAlcixFunction ifAbsent: [ 
		  NotFound signal:
			  'No code producer has been found for given element ' ]
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> producerFor: anAlcixFunction ifNone: aBlock [

	^ producers at: anAlcixFunction ifAbsent: [ aBlock value ]
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> registerSpace: aName [

	| entry |
	mappings at: aName ifPresent: [ self halt ].
	entry := self class new
		         name: aName;
		         parent: self;
		         yourself.
	mappings at: aName put: entry.
	^ entry
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> translatorFor: anAlcixFunction [ 
	^ producers at: anAlcixFunction 
]
