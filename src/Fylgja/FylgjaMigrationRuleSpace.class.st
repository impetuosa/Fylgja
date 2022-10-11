Class {
	#name : #FylgjaMigrationRuleSpace,
	#superclass : #Object,
	#instVars : [
		'parent',
		'name',
		'mappingRules',
		'subspaces',
		'producingRules',
		'delegatingRules',
		'lookupStrategy',
		'ruleChooseStrategy'
	],
	#category : #'Fylgja-MRS'
}

{ #category : #query }
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

{ #category : #query }
FylgjaMigrationRuleSpace >> allPossibleDelegatingRules [

	| thisLevelRules |
	thisLevelRules := (delegatingRules sorted: #priority) collect: [ :r | 
		                  self -> r ].



	^ thisLevelRules , (parent
		   ifNil: [ {  } ]
		   ifNotNil: [ parent allPossibleDelegatingRules ])
]

{ #category : #query }
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
FylgjaMigrationRuleSpace >> chooseRule: aCollection [

	^ self ruleChooseStrategy chooseRule: aCollection
]

{ #category : #copy }
FylgjaMigrationRuleSpace >> copyAllButSubspaces [

	| e |
	e := self class basicNew.
	e class allSlots
		reject: [ :a | { #subspaces. #parent } includes: a name ]
		thenDo: [ :slot | 
			(slot read: self) isCollection ifTrue: [ 
				slot write: (slot read: self) copy to: e ] ].
	e class allSlots
		select: [ :a | { #subspaces. #parent } includes: a name ]
		thenDo: [ :slot | slot write: nil to: e ].
	^ e
]

{ #category : #copy }
FylgjaMigrationRuleSpace >> copySpace [

	| kids copy |
	copy := self copyAllButSubspaces.
	kids := subspaces collect: [ :s | s copySpace ].
	(copy class slotNamed: #subspaces) write: kids to: copy.
	kids do: [ :k | k parent: copy ].
	copy ruleChooseStrategy: ruleChooseStrategy.
	^ copy
]

{ #category : #'public-entity-creation' }
FylgjaMigrationRuleSpace >> ensureNamespace: anEntity [

	^ anEntity mapSpaceAnchor names inject: self into: [ :space :entry | 
		  space
			  mapspaceForName: entry
			  ifAbsent: [ space registerSpace: entry ] ]
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> ensureNamespace: anEntity model: aMOModel [

	^ (self migrationRuleSpaceForModel: aMOModel) ensureNamespace: anEntity
]

{ #category : #'as yet unclassified' }
FylgjaMigrationRuleSpace >> finalizeFylgja [

	subspaces do: #finalizeFylgja.
	mappingRules do: [ :a | a becomeForward: {  } ]
]

{ #category : #initialization }
FylgjaMigrationRuleSpace >> initialize [

	super initialize.
	subspaces := Dictionary new.
	producingRules := OrderedCollection new.
	mappingRules := OrderedCollection new.
	delegatingRules := OrderedCollection new.
]

{ #category : #operations }
FylgjaMigrationRuleSpace >> install: aFylgjaBindingRule [

	aFylgjaBindingRule isBindingRule ifTrue: [ 
		self installMappingRule: aFylgjaBindingRule ].
	aFylgjaBindingRule isProductionRule ifTrue: [ 
		self installProducingRule: aFylgjaBindingRule ].
	aFylgjaBindingRule isDelegatingRule ifTrue: [ 
		self installDelegatingRule: aFylgjaBindingRule ]
]

{ #category : #operations }
FylgjaMigrationRuleSpace >> installDelegatingRule: aFylgjaProductionRule [

	delegatingRules add: aFylgjaProductionRule
]

{ #category : #operations }
FylgjaMigrationRuleSpace >> installMappingRule: aFylgjaProductionRule [

	mappingRules add: aFylgjaProductionRule
]

{ #category : #operations }
FylgjaMigrationRuleSpace >> installProducingRule: aFylgjaProductionRule [

	producingRules add: aFylgjaProductionRule
]

{ #category : #lookup }
FylgjaMigrationRuleSpace >> lookupAllRulesForProducing: aProvenanceEntityRelation toContext: aDestinationContextRelation with: aWriter [

	| thisLevelRules |
		self halt. 
	thisLevelRules := producingRules select: [ :mr | 
		                  mr
			                  matches: aProvenanceEntityRelation
			                  context: aDestinationContextRelation
			                  forWriting: MOType
			                  with: aWriter ].
	^ (thisLevelRules collect: [ :mr | self -> mr ])
	  , (parent ifNil: [ {  } ] ifNotNil: [ 
			   parent
				   lookupAllRulesForProducing: aProvenanceEntityRelation
				   toContext: aDestinationContextRelation
				   with: aWriter ])
]

{ #category : #lookup }
FylgjaMigrationRuleSpace >> lookupContextFor: aProvenanceEntityRelation toContext: aDestinationContextRelation model: aMOModel [
	^ self lookupStrategy
		  mrs:
			  (self mrsAt: aDestinationContextRelation to anchor for: aMOModel)
		  destination: aDestinationContextRelation;
		  yourself
]

{ #category : #lookup }
FylgjaMigrationRuleSpace >> lookupRulesForBinding: aDestinationEntity with: aCandidateRelation inTheContextOf: aDestinationContextRelation [

	| thisLevelRules |
	thisLevelRules := mappingRules select: [ :mr | 
		                  mr
			                  matches: aDestinationEntity
			                  context: aDestinationContextRelation
			                  toBindAs: aCandidateRelation ].


	^ (thisLevelRules collect: [ :mr | self -> mr ])
	  , (parent ifNil: [ {  } ] ifNotNil: [ 
			   parent
				   lookupRulesForBinding: aDestinationEntity
				   with: aCandidateRelation
				   inTheContextOf: aDestinationContextRelation ])
]

{ #category : #lookup }
FylgjaMigrationRuleSpace >> lookupRulesForDelegating: aProvenanceEntity toContext: aDestinationContext with: aWriter [

	^ (delegatingRules select: [ :mr | 
		   mr
			   matches: aProvenanceEntity
			   context: aDestinationContext
			   forWriting: MOType
			   with: aWriter ]) , (parent ifNil: [ {  } ] ifNotNil: [ 
		   parent
			   lookupRulesForDelegating: aProvenanceEntity
			   toContext: aDestinationContext
			   with: aWriter ])
]

{ #category : #lookup }
FylgjaMigrationRuleSpace >> lookupRulesForProducing: aProvenanceEntityRelation toContext: aDestinationContextRelation forWriting: aType with: aWriter [

	| thisLevelRules max |

	thisLevelRules := producingRules select: [ :mr | 
		                  mr
			                  matches: aProvenanceEntityRelation
			                  context: aDestinationContextRelation
			                  forWriting: aType
			                  with: aWriter ].

	^ (thisLevelRules collect: [ :mr | self -> mr ])
	  , (parent ifNil: [ {  } ] ifNotNil: [ 
			   parent
				   lookupRulesForProducing: aProvenanceEntityRelation
				   toContext: aDestinationContextRelation
				   forWriting: aType
				   with: aWriter ])
]

{ #category : #lookup }
FylgjaMigrationRuleSpace >> lookupRulesForProducing: aProvenanceEntityRelation toContext: aDestinationContextRelation with: aWriter [

	| thisLevelRules |

	thisLevelRules := producingRules select: [ :mr | 
		                  mr
			                  matches: aProvenanceEntityRelation
			                  context: aDestinationContextRelation
			                  forWriting: aDestinationContextRelation to class
			                  with: aWriter ].

	^ (thisLevelRules collect: [ :mr | self -> mr ])
	  , (parent ifNil: [ {  } ] ifNotNil: [ 
			   parent
				   lookupRulesForProducing: aProvenanceEntityRelation
				   toContext: aDestinationContextRelation
				   with: aWriter ])
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> lookupStrategy [

	^ lookupStrategy ifNil: [ FylgjaLookUpContext new ]
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> lookupStrategy: aStrategy [

	lookupStrategy := aStrategy
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> mapspaceForName: aString ifAbsent: aFullBlockClosure [

	^ subspaces at: aString ifAbsent: [ aFullBlockClosure value ]
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> migrationRuleSpaceForAnchor: aMOAnchor [

	^ aMOAnchor names
		  inject: self
		  into: [ :space :entry | 
		  space mapspaceForName: entry ifAbsent: [ ^ space ] ]
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> migrationRuleSpaceForModel: aMOModel [

	^ self
		  mapspaceForName: aMOModel name
		  ifAbsent: [ 
		  self error: 'The context model is not part of the mapping space' ]
]

{ #category : #accessing }
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

{ #category : #printing }
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

{ #category : #operations }
FylgjaMigrationRuleSpace >> pullUp: aCollection to: aFylgjaMigrationRuleSpace [

	aCollection do: [ :r | 
		self uninstall: r.
		aFylgjaMigrationRuleSpace install: r ]
]

{ #category : #operations }
FylgjaMigrationRuleSpace >> registerSpace: aName [

	| entry |
	entry := self class new
		         name: aName;
		         parent: self;
		         yourself.
	subspaces at: aName put: entry.
	^ entry
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> ruleChooseStrategy [
	^ ruleChooseStrategy ifNil: [ ruleChooseStrategy := FylgjaChooseRuleStrategy default  ]
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> ruleChooseStrategy: aStrategy [

	ruleChooseStrategy := aStrategy
]

{ #category : #accessing }
FylgjaMigrationRuleSpace >> subspaces [

	^ subspaces values
]

{ #category : #operations }
FylgjaMigrationRuleSpace >> uninstall: aFylgjaBindingRule [

	aFylgjaBindingRule isBindingRule ifTrue: [ 
		^ mappingRules remove: aFylgjaBindingRule ].
	aFylgjaBindingRule isProductionRule ifTrue: [ 
		producingRules remove: aFylgjaBindingRule ].
	aFylgjaBindingRule isDelegatingRule ifTrue: [ 
		delegatingRules remove: aFylgjaBindingRule ]
]
