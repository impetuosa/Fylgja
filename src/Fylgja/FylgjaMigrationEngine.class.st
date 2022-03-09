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
		         toContext: aMOJavaClass
		         destinationModel:
		         (self selectDerivativeModelFor: aMOJavaClass).
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
FylgjaMigrationEngine >> lookupContextFor: aProvenanceEntity toContext: aDestinationContext model: aMOModel [

	^ migrationRuleSpace
		  lookupContextFor: aProvenanceEntity
		  toContext: aDestinationContext
		  model: aMOModel
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> lookupRulesForMapping: aProvenanceEntity toContext: aDestinationContext destinationModel: destinationModel [

	^ (self
		   lookupContextFor: aProvenanceEntity
		   toContext: aDestinationContext
		   model: destinationModel) lookupRulesForMapping: aProvenanceEntity
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> lookupRulesForProducing: aProvenanceEntity toContext: aDestinationContext destinationModel: destinationModel [

	^ (self
		   lookupContextFor: aProvenanceEntity
		   toContext: aDestinationContext
		   model: destinationModel) lookupRulesForProducing:
		  aProvenanceEntity
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
	element := aModifiedFylgjaMigrationEngine readEntitysContextualizingRelation:
		           aProvenanceReferenceEntity.
	destinationContext := aModifiedFylgjaMigrationEngine readEntitysContextualizingRelation:
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

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> migrate: aProvenanceEntityRelation intoDestinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ self
		  produce: aProvenanceEntityRelation
		  destinationWriter: aDestinationWriter
		  lookUp: aFylgjaLookUpContext
		  using: aFylgjaDerivativeModel
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
FylgjaMigrationEngine >> produce: aProvenanceEntityRelation destinationWriter: aWriter lookUp: aLookupContext using: aModifiedFylgjaMigrationEngine [

	| rules relation partialResult rule |
	relation := aModifiedFylgjaMigrationEngine readRelation:
		            aProvenanceEntityRelation.



	rules := aLookupContext
		         lookupRulesForProducing: relation
		         forWriting: aWriter writingType.

	rules ifEmpty: [ NotFound signal: 'No producing rule found ' ].
	rule := rules first.
	partialResult := rule
		                 applyTo: relation
		                 destinationWriter: aWriter
		                 lookUp: aLookupContext
		                 using: aModifiedFylgjaMigrationEngine.

	self trace: relation to: rule produced: partialResult.
	^ partialResult
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

	| elementRelation destinationContextRelation resultingRelation lookup  |

	elementRelation := aModifiedFylgjaMigrationEngine readEntitysContextualizingRelation:
		           aProvenanceEntity.

	destinationContextRelation := aModifiedFylgjaMigrationEngine readEntitysContextualizingRelation:
		                      aDestinationContext.

	lookup := self
		          lookupContextFor: elementRelation
		          toContext: destinationContextRelation
		          model:
			          (aModifiedFylgjaMigrationEngine 
				           selectDerivativeModelFor: aDestinationContext).

	resultingRelation := (aModifiedFylgjaMigrationEngine 
		                  selectDerivativeModelFor: aDestinationContext)
		                 writer
		                 updaterFor: destinationContextRelation
		                 with: elementRelation
		                 do: [ :elem :destinationWriter | 
			                 self
				                 produce: elementRelation
				                 destinationWriter: destinationWriter
				                 lookUp: lookup
				                 using: aModifiedFylgjaMigrationEngine ].

	^ resultingRelation
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> selectDerivativeModelFor: aDestinationContext [

	^ models detect: [ :d | d includes: aDestinationContext ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> trace: aProvenanceEntity to: aRule produced: partialResult [

	tracing
		trace: aProvenanceEntity
		to: aRule
		produced: partialResult
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> traces [
	^ tracing traces
]
