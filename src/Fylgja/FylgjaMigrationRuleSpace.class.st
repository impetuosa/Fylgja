Class {
	#name : #FylgjaMigrationRuleSpace,
	#superclass : #Object,
	#instVars : [
		'parent',
		'name',
		'mappingRules',
		'subspaces',
		'producingRules',
		'delegatingRules'
	],
	#category : #'Fylgja-Model'
}

{ #category : #'public-entity-creation' }
FylgjaMigrationRuleSpace >> ensureNamespace: aMOMethod [

	^ aMOMethod mapSpaceAnchor names inject: self into: [ :space :entry | 
		  space
			  mapspaceForName: entry
			  ifAbsent: [ space registerSpace: entry ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> ensureNamespace: aMOMethod model: aMOModel [

	^ (self migrationRuleSpaceForModel: aMOModel) ensureNamespace: aMOMethod
]

{ #category : #public }
FylgjaMigrationRuleSpace >> get: anAlcixFunction [

	^ self get: anAlcixFunction ifAbsent: [ 
		  NotFound signal:
			  'Cannotfind a suitable mapping entity for '
			  , anAlcixFunction asString ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> get: anAlcixFunction ifAbsent: aFullBlockClosure [

	^ subspaces at: anAlcixFunction ifAbsent: [ aFullBlockClosure value ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> getOrCreateMapspaceFor: aMOAnchor [

	^ aMOAnchor names inject: self into: [ :space :entry | 
		  space
			  mapspaceForName: entry
			  ifAbsent: [ space registerSpace: entry ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> initialize [

	super initialize.
	subspaces := Dictionary new.
	producingRules := OrderedCollection new.
	mappingRules := OrderedCollection new.
	delegatingRules := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> installDelegatingRule: aFylgjaProductionRule [

	delegatingRules add: aFylgjaProductionRule
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> installMappingRule: aFylgjaProductionRule [

	mappingRules add: aFylgjaProductionRule
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> installProducingRule: aFylgjaProductionRule [

	producingRules add: aFylgjaProductionRule
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> lookupRulesForDelegating: aProvenanceEntity toContext: aDestinationContext [

	^ (delegatingRules select: [ :mr | 
		   mr matches: aProvenanceEntity context: aDestinationContext ]) , (parent
		   ifNil: [ {  } ]
		   ifNotNil: [ 
		   parent lookupRulesForDelegating: aProvenanceEntity toContext: aDestinationContext ])
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> lookupRulesForMapping: anAlcixFunction [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> lookupRulesForMapping: aProvenanceEntity toContext: aDestinationContext [

	^ (mappingRules select: [ :mr | 
		   mr matches: aProvenanceEntity context: aDestinationContext ]) , (parent
		   ifNil: [ {  } ]
		   ifNotNil: [ 
		   parent lookupRulesForMapping: aProvenanceEntity toContext: aDestinationContext ])
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> lookupRulesForMapping: anAlcixFunction toContext: aMOClass model: aMOModel [

	^ ((self migrationRuleSpaceForModel: aMOModel) migrationRuleSpaceForAnchor: aMOClass anchor)
		  lookupRulesForMapping: anAlcixFunction
		  toContext: aMOClass
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> lookupRulesForProducing: anAlcixFunction toContext: aMOClass [

	^ (producingRules select: [ :mr | 
		   mr matches: anAlcixFunction context: aMOClass ] thenCollect: [ : mr | self -> mr ] ) , (parent
		   ifNil: [ {  } ]
		   ifNotNil: [ 
		   parent lookupRulesForProducing: anAlcixFunction toContext: aMOClass ])
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> lookupRulesForProducing: anAlcixFunction toContext: aMOClass model: aMOModel [

	^ ((self migrationRuleSpaceForModel: aMOModel) migrationRuleSpaceForAnchor: aMOClass anchor)
		  lookupRulesForProducing: anAlcixFunction
		  toContext: aMOClass
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> mapspaceForName: aString ifAbsent: aFullBlockClosure [

	^ subspaces at: aString ifAbsent: [ aFullBlockClosure value ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> migrationRuleSpaceForAnchor: aMOAnchor [

	^ aMOAnchor names
		  inject: self
		  into: [ :space :entry | 
		  space mapspaceForName: entry ifAbsent: [ ^ space ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> migrationRuleSpaceForModel: aMOModel [

	^ self
		  mapspaceForName: aMOModel name
		  ifAbsent: [ 
		  self error: 'The context model is not part of the mapping space' ]
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> name: aString [

	name := aString
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> parent: aFylgjaMapSpace [ 
	parent := aFylgjaMapSpace
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> printOn: aStream [

	parent
		ifNil: [ 
			aStream
				nextPutAll: 'MapSpace: ';
				nextPutAll: (name ifNil: '/root') ]
		ifNotNil: [ 
			parent printOn: aStream.
			aStream
				nextPutAll: #/;
				nextPutAll: name ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> registerSpace: aName [

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
FylgjaMigrationRuleSpace >> subspaces [

	^ subspaces values
]
