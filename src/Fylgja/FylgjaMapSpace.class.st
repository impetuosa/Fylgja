Class {
	#name : #FylgjaMapSpace,
	#superclass : #Object,
	#instVars : [
		'parent',
		'name',
		'mappingRules',
		'subspaces',
		'producingRules'
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

	^ subspaces at: anAlcixFunction ifAbsent: [ aFullBlockClosure value ]
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
	subspaces := Dictionary new.
	producingRules := OrderedCollection new.
	mappingRules := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> lookupRulesFor: anAlcixFunction toContext: aMOClass [

	^ (mappingRules select: [ :mr | 
		   mr matches: anAlcixFunction context: aMOClass ])
	  , (producingRules select: [ :mr | 
			   mr matches: anAlcixFunction context: aMOClass ]) , (parent
		   ifNil: [ {  } ]
		   ifNotNil: [ 
		   parent lookupRulesFor: anAlcixFunction toContext: aMOClass ])
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> lookupRulesForMapping: anAlcixFunction [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> lookupRulesForMapping: anAlcixFunction toContext: aMOClass [

	^ (mappingRules select: [ :mr | 
		   mr matches: anAlcixFunction context: aMOClass ]) , (parent
		   ifNil: [ {  } ]
		   ifNotNil: [ 
		   parent lookupRulesForMapping: anAlcixFunction toContext: aMOClass ])
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> lookupRulesForMapping: anAlcixFunction toContext: aMOClass model: aMOModel [

	^ ((self modelMapspace: aMOModel) mapspaceForAnchor: aMOClass anchor)
		  lookupRulesForMapping: anAlcixFunction
		  toContext: aMOClass
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> lookupRulesForProducing: anAlcixFunction toContext: aMOClass [

	^ (producingRules select: [ :mr | 
		   mr matches: anAlcixFunction context: aMOClass ]) , (parent
		   ifNil: [ {  } ]
		   ifNotNil: [ 
		   parent lookupRulesForProducing: anAlcixFunction toContext: aMOClass ])
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> lookupRulesForProducing: anAlcixFunction toContext: aMOClass model: aMOModel [

	^ ((self modelMapspace: aMOModel) mapspaceForAnchor: aMOClass anchor)
		  lookupRulesForMapping: anAlcixFunction
		  toContext: aMOClass
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> mapspaceForAnchor: aMOAnchor [

	^ aMOAnchor names
		  inject: self
		  into: [ :space :entry | 
		  space mapspaceForName: entry ifAbsent: [ ^ space ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> mapspaceForName: aString ifAbsent: aFullBlockClosure [

	^ subspaces at: aString ifAbsent: [ aFullBlockClosure value ]
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> modelMapspace: aMOModel [

	^ self
		  mapspaceForName: aMOModel name
		  ifAbsent: [ 
		  self error: 'The context model is not part of the mapping space' ]
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

	| entry |
	subspaces at: aName ifPresent: [ self halt ].
	entry := self class new
		         name: aName;
		         parent: self;
		         yourself.
	subspaces at: aName put: entry.
	^ entry
]

{ #category : #'as yet unclassified' }
FylgjaMapSpace >> subspaces [

	^ subspaces values
]
