Class {
	#name : #FylgjaMigrationEngine,
	#superclass : #Object,
	#instVars : [
		'models',
		'migrationRuleSpace',
		'tracing'
	],
	#category : #'Fylgja-Model'
}

{ #category : #accessing }
FylgjaMigrationEngine >> activateTracing [
	tracing := tracing activateTracing 
]

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
	tracing := FylgjaMigrationNullTracingStrategy new
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> lookupRulesForMapping: aProvenanceEntity toContext: aDestinationContext [

	^ self
		  lookupRulesForMapping: aProvenanceEntity
		  toContext: aDestinationContext
		  model: (self selectDerivativeModelFor: aDestinationContext)
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
		  model: (self selectDerivativeModelFor: aMOClass)
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

	| rules element destinationContext |
	element := aModifiedFylgjaMigrationEngine readEntity:
		           aProvenanceReferenceEntity.
	destinationContext := aModifiedFylgjaMigrationEngine readEntity:
		                      aDestinationContext.
	rules := self
		         lookupRulesForMapping: element
		         toContext: destinationContext
		         destinationModel:
			         (aModifiedFylgjaMigrationEngine selectDerivativeModelFor:
				          aDestinationContext).

	rules ifEmpty: [ 
		^ self
			  produce: aProvenanceReferenceEntity
			  into: destinationContext
			  using: aModifiedFylgjaMigrationEngine ].

	self halt.
	^ rules first
		  applyTo: element
		  context: destinationContext
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

{ #category : #accessing }
FylgjaMigrationEngine >> noTracing [
	tracing := tracing noTracing
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

	| rules element destinationContext partialResult |
	element := aModifiedFylgjaMigrationEngine readEntity:
		           aProvenanceEntity.

	destinationContext := aModifiedFylgjaMigrationEngine readEntity:
		                      aDestinationContext.

	rules := self
		         lookupRulesForProducing: element
		         toContext: destinationContext
		         destinationModel:
			         (aModifiedFylgjaMigrationEngine selectDerivativeModelFor:
				          aDestinationContext).

	rules ifEmpty: [ NotFound signal: 'No producing rule found ' ].

	partialResult := rules first
		                 applyTo: element
		                 context: destinationContext
		                 using: aModifiedFylgjaMigrationEngine.

	self
		trace: element
		to: aDestinationContext
		produced: partialResult.
	^ partialResult
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> selectDerivativeModelFor: aDestinationContext [

	^ models detect: [ :d | d includes: aDestinationContext ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> trace: aProvenanceEntity to: aDestinationContext produced: partialResult [

	tracing
		trace: aProvenanceEntity
		to: aDestinationContext
		produced: partialResult
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> traces [
	^ tracing traces
]
