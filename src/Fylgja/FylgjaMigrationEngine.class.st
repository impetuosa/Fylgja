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
FylgjaMigrationEngine >> forceMapStubs: aModifiedFylgjaMigrationEngine [

	^ aModifiedFylgjaMigrationEngine derivativeModels do: [ :contextModel | 
		  self
			  forceReMappingRuleOverStubs: contextModel allStubs
			  contextModel: contextModel
			  using: aModifiedFylgjaMigrationEngine ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> forceReMappingRuleOverStubs: aCollection contextModel: contextModel using: aModifiedFylgjaMigrationEngine [

	| newElement |
	aCollection do: [ :stub | 
		| elementRelation destinationContextRelation lookup |
		elementRelation := stub provenance.

		destinationContextRelation := aModifiedFylgjaMigrationEngine 
			                              readEntitysContextualizingRelation:
			                              stub parent.

		lookup := self
			          lookupContextFor: elementRelation
			          toContext: destinationContextRelation
			          model: contextModel.

		newElement := aModifiedFylgjaMigrationEngine
			              mapEntity: stub parent
			              as: stub provenance
			              croppingRelationsWith: [ :a | a ]
			              usingWriter: contextModel writer
			              lookUp: lookup.


		self model: contextModel swap: stub with: newElement ]
]

{ #category : #accessing }
FylgjaMigrationEngine >> initialize [

	super initialize.
	migrationRuleSpace := FylgjaMigrationRuleSpace new.
	tracing := FylgjaMigrationNullTracingStrategy new.
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> lookupContextFor: aProvenanceEntity toContext: aDestinationContext model: aMOModel [

	^ migrationRuleSpace
		  lookupContextFor: aProvenanceEntity
		  toContext: aDestinationContext
		  model: aMOModel
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> lookupRulesForProducing: aProvenanceEntity toContext: aDestinationContext destinationModel: destinationModel [

	^ (self
		   lookupContextFor: aProvenanceEntity
		   toContext: aDestinationContext
		   model: destinationModel) lookupRulesForProducing:
		  aProvenanceEntity
]

{ #category : #accessing }
FylgjaMigrationEngine >> map: aProvenanceEntity to: aDestinationEntity [

	| derivative |
	derivative := self derivative.

	self map: aProvenanceEntity to: aDestinationEntity using: derivative.


	^ derivative
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> map: aProvenanceEntity to: aDestinationEntity using: aModifiedFylgjaMigrationEngine [
  | context |
  self assert: aProvenanceEntity isDeclaration.
  self assert: aDestinationEntity isDeclaration.
  aModifiedFylgjaMigrationEngine setExplicitMapping: aProvenanceEntity to: aDestinationEntity.
  context := aModifiedFylgjaMigrationEngine selectDerivativeModelFor: aDestinationEntity.
  FylgjaRuleInstaller new
     context: context;
     whenIsReferenceWithCandidate: aProvenanceEntity;
     bindRewriteTo: aDestinationEntity;
     installInto: aModifiedFylgjaMigrationEngine.
  ^aModifiedFylgjaMigrationEngine
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> mapEntity: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock usingWriter: aWriter lookUp: aLookupContext using: aModifiedFylgjaMigrationEngine [
	| rules partialResult rule |
	
	rules := aLookupContext
		         lookupRulesForBinding: aDestinationEntity
		         with: aCandidateRelation.

	rules ifEmpty: [ NotFound signal: 'No mapping rule found ' ].
	rule := rules first.
	partialResult := rule
		                 bind: aDestinationEntity
		                 as: aCandidateRelation
		                 croppingRelationsWith: aBlock
		                 destinationWriter: aWriter
		                 lookUp: aLookupContext
		                 using: aModifiedFylgjaMigrationEngine.

	^ partialResult
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> migrate: aProvenanceEntityRelation croppingRelationsWith: aBlock intoDestinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ self
		  produce: aProvenanceEntityRelation
		  croppingRelationsWith: aBlock
		  destinationWriter: aDestinationWriter
		  lookUp: aFylgjaLookUpContext
		  using: aFylgjaDerivativeModel

]

{ #category : #accessing }
FylgjaMigrationEngine >> migrationRuleSpace [

	^ migrationRuleSpace ifNil: [ migrationRuleSpace := FylgjaMigrationRuleSpace new ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> model: aMOModelDerivative swap: aFylgjaCandidateStub with: aMOVariableReference [
	aMOModelDerivative
		swap: aFylgjaCandidateStub
		with: aMOVariableReference.
	tracing swap: aFylgjaCandidateStub with: aMOVariableReference
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
FylgjaMigrationEngine >> produce: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aWriter lookUp: aLookupContext using: aModifiedFylgjaMigrationEngine [

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
		                 croppingRelationsWith: aBlock
		                 destinationWriter: aWriter
		                 lookUp: aLookupContext
		                 using: aModifiedFylgjaMigrationEngine.

	self
		trace: relation
		to: rule
		produced: partialResult
		using: aModifiedFylgjaMigrationEngine.
	^ partialResult
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> produce: aProvenanceEntity croppingRelationsWith: aBlock into: aDestinationContext [

	| result derivative |
	derivative := self derivative.

	result := self
		          produce: aProvenanceEntity
		          croppingRelationsWith: aBlock
		          into: aDestinationContext
		          using: derivative.

	
	^ FylgjaDerivationResult new
		  derivative: derivative;
		  result: result;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> produce: aProvenanceEntity croppingRelationsWith: aBlock into: aDestinationContext using: aModifiedFylgjaMigrationEngine [

	| elementRelation destinationContextRelation resultingRelation lookup destinationModel |
	elementRelation := aModifiedFylgjaMigrationEngine 
		                   readEntitysContextualizingRelation:
		                   aProvenanceEntity.

	destinationContextRelation := aModifiedFylgjaMigrationEngine 
		                              readEntitysContextualizingRelation:
		                              aDestinationContext.
	destinationModel := aModifiedFylgjaMigrationEngine 
		                    selectDerivativeModelFor: aDestinationContext.
	lookup := self
		          lookupContextFor: elementRelation
		          toContext: destinationContextRelation
		          model: destinationModel.


	resultingRelation := destinationModel writer
		                     updaterFor: destinationContextRelation
		                     with: elementRelation
		                     do: [ :elem :destinationWriter | 
			                     self
				                     produce: elementRelation
				                     croppingRelationsWith: aBlock
				                     destinationWriter: destinationWriter
				                     lookUp: lookup
				                     using: aModifiedFylgjaMigrationEngine ].

	^ resultingRelation
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> produce: aProvenanceEntity into: aDestinationContext [

	^ self
		  produce: aProvenanceEntity
		  croppingRelationsWith: [ :a | a ]
		  into: aDestinationContext
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> selectDerivativeModelFor: aDestinationContext [

	^ models detect: [ :d | d includes: aDestinationContext ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> trace: aProvenanceEntity to: aRule produced: partialResult using: aModifiedFylgjaMigrationEngine [

	tracing trace: aProvenanceEntity to: aRule produced: partialResult.

	partialResult isDeclaration ifTrue: [ 
		self
			map: aProvenanceEntity to
			to: partialResult
			using: aModifiedFylgjaMigrationEngine ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> traces [
	^ tracing traces
]
