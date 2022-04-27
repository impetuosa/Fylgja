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
	#category : #'Fylgja-MRS'
}

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> allPossibleBindingRules [

	| thisLevelRules |
	thisLevelRules := (mappingRules sort: #priority descending ) collect: [ :r | 
		                  self -> r ].


	^ thisLevelRules
	  ,
	  (parent
		   ifNil: [ {  } ]
		   ifNotNil: [ parent allPossibleBindingRules ])
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> allPossibleDelegatingRules [

	| thisLevelRules |
	thisLevelRules := (delegatingRules sorted: #priority) collect: [ :r | 
		                  self -> r ].



	^ thisLevelRules , (parent
		   ifNil: [ {  } ]
		   ifNotNil: [ parent allPossibleDelegatingRules ])
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> allPossibleProducingRules [

	| thisLevelRules |
	thisLevelRules := (producingRules sorted: #priority descending ) collect: [ :r | 
		                  self -> r ].


	^ thisLevelRules
	  ,
	  (parent
		   ifNil: [ {  } ]
		   ifNotNil: [ parent allPossibleProducingRules ])
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> copySpace [

	| kids copy |
	copy := self shallowCopy.

	kids := subspaces collect: [ :s | s copySpace ].
	kids do: [ :k | k parent: copy ].
	^ copy
]

{ #category : #'public-entity-creation' }
FylgjaMigrationRuleSpace >> ensureNamespace: anEntity [

	^ anEntity mapSpaceAnchor names inject: self into: [ :space :entry | 
		  space
			  mapspaceForName: entry
			  ifAbsent: [ space registerSpace: entry ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> ensureNamespace: anEntity model: aMOModel [

	^ (self migrationRuleSpaceForModel: aMOModel) ensureNamespace: anEntity
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

{ #category : #initialization }
FylgjaMigrationRuleSpace >> install: aFylgjaBindingRule [

	aFylgjaBindingRule isBindingRule ifTrue: [ 
		self installMappingRule: aFylgjaBindingRule ].
	aFylgjaBindingRule isProductionRule ifTrue: [ 
		self installProducingRule: aFylgjaBindingRule ].
	aFylgjaBindingRule isDelegatingRule ifTrue: [ 
		self installDelegatingRule: aFylgjaBindingRule ]
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
FylgjaMigrationRuleSpace >> lookupContextFor: aProvenanceEntityRelation toContext: aDestinationContextRelation model: aMOModel [

	^ FylgjaLookUpContext new
		  mrs:
			  (self mrsAt: aDestinationContextRelation to anchor for: aMOModel)
		  destination: aDestinationContextRelation;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> lookupRulesForBinding: aDestinationEntity with: aCandidateRelation inTheContextOf: aDestinationContextRelation [

	| thisLevelRules max |
	thisLevelRules := mappingRules select: [ :mr | 
		                  mr
			                  matches: aDestinationEntity
			                  context: aDestinationContextRelation
			                  toBindAs: aCandidateRelation ].
	thisLevelRules size > 1 ifTrue: [ 
		max := thisLevelRules max: #priority.
		thisLevelRules := thisLevelRules select: [ :a | a priority = max ] ].


	^ (thisLevelRules collect: [ :mr | self -> mr ])
	  , (parent ifNil: [ {  } ] ifNotNil: [ 
			   parent
				   lookupRulesForBinding: aDestinationEntity
				   with: aCandidateRelation
				   inTheContextOf: aDestinationContextRelation ])
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> lookupRulesForDelegating: aProvenanceEntity toContext: aDestinationContext [

	^ (delegatingRules select: [ :mr | 
		   mr
			   matches: aProvenanceEntity
			   context: aDestinationContext
			   forWriting: MOType ]) , (parent ifNil: [ {  } ] ifNotNil: [ 
		   parent
			   lookupRulesForDelegating: aProvenanceEntity
			   toContext: aDestinationContext ])
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> lookupRulesForProducing: aProvenanceEntityRelation toContext: aDestinationContextRelation [

	| thisLevelRules max |
	thisLevelRules := producingRules select: [ :mr | 
		                  mr
			                  matches: aProvenanceEntityRelation
			                  context: aDestinationContextRelation
			                  forWriting: MOType ].
	thisLevelRules size > 1 ifTrue: [ 
		max := thisLevelRules max: #priority.
		thisLevelRules := thisLevelRules select: [ :a | a priority = max ] ].

	^ (thisLevelRules collect: [ :mr | self -> mr ])
	  , (parent ifNil: [ {  } ] ifNotNil: [ 
			   parent
				   lookupRulesForProducing: aProvenanceEntityRelation
				   toContext: aDestinationContextRelation ])
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> lookupRulesForProducing: aProvenanceEntityRelation toContext: aDestinationContextRelation forWriting: aType [

	| thisLevelRules max |
	thisLevelRules := producingRules select: [ :mr | 
		                  mr
			                  matches: aProvenanceEntityRelation
			                  context: aDestinationContextRelation
			                  forWriting: aType ].
	thisLevelRules size > 1 ifTrue: [ 
		max := thisLevelRules max: #priority.
		thisLevelRules := thisLevelRules select: [ :a | a priority = max ] ].

	^ (thisLevelRules collect: [ :mr | self -> mr ])
	  , (parent ifNil: [ {  } ] ifNotNil: [ 
			   parent
				   lookupRulesForProducing: aProvenanceEntityRelation
				   toContext: aDestinationContextRelation
				   forWriting: aType ])
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

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> mrsAt: anAnchor for: aMOModel [

	^ (self migrationRuleSpaceForModel: aMOModel) 
		  migrationRuleSpaceForAnchor: anAnchor
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> name [
	^ name
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> name: aString [

	name := aString
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> parent [
	^ parent
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> parent: aFylgjaMapSpace [ 
	parent := aFylgjaMapSpace
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> parents [

	| parents current |
	parents := OrderedCollection new.
	current := self.
	[ current parent isNil ] whileFalse: [ 
		current := current parent.
		parents add: current ].
	^ parents
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> printOn: aStream [

	parent
		ifNil: [ 
			aStream
				nextPutAll: 'MRS ';
				nextPutAll: (name ifNil: '/mrs') ]
		ifNotNil: [ 
			parent printOn: aStream.
			aStream
				nextPutAll: #/;
				nextPutAll: name ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> pullUp: aCollection to: aFylgjaMigrationRuleSpace [

	aCollection do: [ :r | 
		self uninstall: r.
		aFylgjaMigrationRuleSpace install: r ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> pullUpTo: aFylgjaMigrationRuleSpace [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> registerSpace: aName [

	| entry |
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

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> uninstall: aFylgjaBindingRule [

	aFylgjaBindingRule isBindingRule ifTrue: [ 
		^ mappingRules remove: aFylgjaBindingRule ].
	aFylgjaBindingRule isProductionRule ifTrue: [ 
		producingRules remove: aFylgjaBindingRule ].
	aFylgjaBindingRule isDelegatingRule ifTrue: [ 
		delegatingRules remove: aFylgjaBindingRule ]
]
