Class {
	#name : #FylgjaMigrationEngine,
	#superclass : #Object,
	#instVars : [
		'models',
		'migrationRuleSpace'
	],
	#category : #'Fylgja-Model'
}

{ #category : #adding }
FylgjaMigrationEngine >> addModel: aMOHeterogeneousAbstractSemanticGraph [

	self migrationRuleSpace registerSpace: aMOHeterogeneousAbstractSemanticGraph name.
	^ self models add: aMOHeterogeneousAbstractSemanticGraph.
	
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> derivative [

	^ FylgjaDerivativeModel new
		  fylgja: self;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> get: anAlcixFunction for: aMOJavaClass [

	| rules |
	rules := self
		         lookupRulesForMapping: anAlcixFunction
		         toContext: aMOJavaClass.
	rules ifEmpty: [ NotFound signal: 'No mapping rule found ' ].
	^ rules first applyTo: anAlcixFunction context: aMOJavaClass
]

{ #category : #accessing }
FylgjaMigrationEngine >> initialize [

	super initialize. 
	migrationRuleSpace := FylgjaMigrationRuleSpace new.
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> lookupRulesForMapping: aProvenanceEntity toContext: aDestinationContext [

	^ self
		  lookupRulesForMapping: aProvenanceEntity
		  toContext: aDestinationContext
		  model: (self selectDestinationModelFor: aDestinationContext)
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> lookupRulesForMapping: aProvenanceEntity toContext: aDestinationContext destinationModel: destinationModel [

	| rules |
	rules := self
		         lookupRulesForMapping: aProvenanceEntity
		         toContext: aDestinationContext
		         model: destinationModel.
	[ 
	rules asDictionary values.
	^ rules collect: #value ]
		on: Error
		do: [ 
			self error:
				'Rule selection collision: More than one rule applies on the same map space for the given entity! ' ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> lookupRulesForMapping: aProvenanceEntity toContext: aDestinationContext model: aModel [ 

	^ migrationRuleSpace
		  lookupRulesForMapping: aProvenanceEntity
		  toContext: aDestinationContext
		  model: aModel
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> lookupRulesForProducing: aProvenanceEntity toContext: aMOClass [

	^ self
		  lookupRulesForProducing: aProvenanceEntity
		  toContext: aMOClass
		  model: (self selectDestinationModelFor: aMOClass)
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> lookupRulesForProducing: aProvenanceEntity toContext: aDestinationContext destinationModel: destinationModel [

	| rules |
	rules := self
		         lookupRulesForProducing: aProvenanceEntity
		         toContext: aDestinationContext
		         model: destinationModel.
	[ 
	rules asDictionary values.
	^ rules collect: #value ]
		on: Error
		do: [ 
			self error:
				'Rule selection collision: More than one rule applies on the same map space for the given entity! ' ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> lookupRulesForProducing: aProvenanceEntity toContext: aDestinationContext model: aModel [ 

	^ migrationRuleSpace
		  lookupRulesForProducing: aProvenanceEntity
		  toContext: aDestinationContext
		  model: aModel
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> map: aProvenanceReferenceEntity into: aDestinationContext [

	| result derivative |
	derivative := self derivative.
	result := self
		          map: aProvenanceReferenceEntity
		          into: aDestinationContext
		          using: derivative.
	^ FylgjaDerivationResult new
		  derivative: derivative;
		  result: result;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> map: aProvenanceReferenceEntity into: aDestinationContext using: aModifiedFylgjaMigrationEngine [

	| rules element |
	element := (aModifiedFylgjaMigrationEngine readerFor:
		            aProvenanceReferenceEntity) read:
		           aProvenanceReferenceEntity.
	rules := self
		         lookupRulesForMapping: element
		         toContext: aDestinationContext
		         destinationModel:
			         (aModifiedFylgjaMigrationEngine 
				          selectDestinationModelFor: aDestinationContext).

	rules ifEmpty: [ NotFound signal: 'No producing rule found ' ].

	^ rules first
		  applyTo: element
		  context: aDestinationContext
		  using: aModifiedFylgjaMigrationEngine
]

{ #category : #accessing }
FylgjaMigrationEngine >> migrationRuleSpace [

	^ migrationRuleSpace ifNil: [ migrationRuleSpace := FylgjaMigrationRuleSpace new ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> models [ 

	^ models ifNil: [ models := Set new ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> produce: aProvenanceEntity into: aDestinationContext [

	| result derivative |
	derivative := self derivative.
	result := self
		          produce: aProvenanceEntity
		          into: aDestinationContext
		          using: derivative.
	^ FylgjaDerivationResult new
		  derivative: derivative;
		  result: result;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> produce: aProvenanceEntity into: aDestinationContext using: aModifiedFylgjaMigrationEngine [

	| rules element |
	element := (aModifiedFylgjaMigrationEngine readerFor: aProvenanceEntity) 
		           read: aProvenanceEntity.
	rules := self
		         lookupRulesForProducing: element
		         toContext: aDestinationContext
		         destinationModel:
		         (aModifiedFylgjaMigrationEngine selectDestinationModelFor:
			          aDestinationContext).

	rules ifEmpty: [ NotFound signal: 'No producing rule found ' ].

	^ rules first
		  applyTo: element
		  context: aDestinationContext
		  using: aModifiedFylgjaMigrationEngine
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> selectDestinationModelFor: aDestinationContext [

	^ models detect: [ :d | d entities includes: aDestinationContext ]
]
