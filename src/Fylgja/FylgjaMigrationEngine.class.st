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
FylgjaMigrationEngine >> bind: aCollection contextModel: aMOModelDerivative using: aFylgjaDerivativeModel [

	| lookup destinationContext |
	(aCollection select: [ :a | a parent isNotNil ]) do: [ :e | 
		destinationContext := aFylgjaDerivativeModel 
			                      readEntitysContextualizingRelation: e parent.
		lookup := aFylgjaDerivativeModel
			          lookupContextFor: e
			          toContext: destinationContext
			          model: aMOModelDerivative.
		self
			mapEntity: e
			as: (MODeclarationStructuralRelation nullCandidateRelationTo: nil)
			croppingRelationsWith: [ :a | a ]
			usingWriter: aMOModelDerivative writer
			lookUp: lookup
			using: aFylgjaDerivativeModel ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> bindCandidateless: aFylgjaDerivativeModel [

	aFylgjaDerivativeModel derivativeModels
		select: [ :a | a hasBeenModified ]
		thenDo: [ :contextModel | 
			self
				bind: contextModel candidatelessEntities
				contextModel: contextModel
				using: aFylgjaDerivativeModel ]
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
		  contextModel hasBeenModified ifTrue: [ 
			  self
				  forceReMappingRuleOverStubs: contextModel allStubs
				  contextModel: contextModel
				  using: aModifiedFylgjaMigrationEngine ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> forceReMappingRuleOverStubs: aCollection contextModel: contextModel using: aModifiedFylgjaMigrationEngine [

	| newElement |

	aCollection
		reject: [ :stub | stub provenance to isNil ]
		thenDo: [ :stub | 
			| elementRelation destinationContextRelation lookup |
			elementRelation := stub provenance.

			destinationContextRelation := aModifiedFylgjaMigrationEngine 
				                              readEntitysContextualizingRelation:
				                              stub parent.

			lookup := aModifiedFylgjaMigrationEngine
				          lookupContextFor: elementRelation
				          toContext: destinationContextRelation
				          model: contextModel.

			newElement := aModifiedFylgjaMigrationEngine
				              mapEntity: stub parent
				              as: stub provenance
				              croppingRelationsWith: [ :a | a ]
				              usingWriter: contextModel writer
				              lookUp: lookup.

			(stub parent allCandidateRelations anySatisfy: [ :a | a to = stub ]) 
				ifFalse: [ contextModel removeStub: stub ].

			self
				model: contextModel
				swap: destinationContextRelation to
				with: newElement ]
]

{ #category : #accessing }
FylgjaMigrationEngine >> initialize [

	super initialize.
	migrationRuleSpace := FylgjaMigrationRuleSpace new.
	tracing := FylgjaMigrationNullTracingStrategy new.
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> lookupContextFor: aProvenanceEntity toContext: aDestinationContext model: aMOModel using: aMOModelDerivative [

	^ aMOModelDerivative migrationRuleSpace
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

	^ self
		  map: aProvenanceEntity
		  to: aDestinationEntity
		  using: aModifiedFylgjaMigrationEngine
		  or: [ 
			  aModifiedFylgjaMigrationEngine
				  addDeferredMapping: aProvenanceEntity
				  to: aDestinationEntity ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> map: aProvenanceEntity to: aDestinationEntity using: aModifiedFylgjaMigrationEngine atContext: context [

	FylgjaRuleInstaller new
		context: context;
		whenIsReferenceWithCandidate: aProvenanceEntity;
		bindRewriteTo: aDestinationEntity;
		installInto: aModifiedFylgjaMigrationEngine.
	^ aModifiedFylgjaMigrationEngine
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> map: aProvenanceEntity to: aDestinationEntity using: aModifiedFylgjaMigrationEngine or: aBlock [

	self assert: aProvenanceEntity isDeclaration.
	self assert: aDestinationEntity isDeclaration.

	(aDestinationEntity parentForContext isNil or: [ 
		 aDestinationEntity anchor isNil ])
		ifTrue: [ aBlock value ]
		ifFalse: [ 
			self
				map: aProvenanceEntity
				to: aDestinationEntity
				using: aModifiedFylgjaMigrationEngine
				atContext: aDestinationEntity parentForContext ].



	^ aModifiedFylgjaMigrationEngine
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
FylgjaMigrationEngine >> mapOrFail: aProvenanceEntity to: aDestinationEntity using: aModifiedFylgjaMigrationEngine [

	^ self
		  map: aProvenanceEntity
		  to: aDestinationEntity
		  using: aModifiedFylgjaMigrationEngine
		  or: [ FylgjaMapError signal: ' Cannot map' ]
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
FylgjaMigrationEngine >> model: aMOModelDerivative swap: anOriginalReference with: aBoundedReference [

	aMOModelDerivative swap: anOriginalReference with: aBoundedReference.
	tracing swap: anOriginalReference with: aBoundedReference
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> models [ 

	^ models ifNil: [ models := Set new ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> mrsFor: aDestinationContext using: aModifiedFylgjaMigrationEngine [

	| destinationModel |
	destinationModel := aModifiedFylgjaMigrationEngine 
		                    selectDerivativeModelFor: aDestinationContext.
	^ aModifiedFylgjaMigrationEngine migrationRuleSpace
		  mrsAt: aDestinationContext anchor
		  for: destinationModel
]

{ #category : #accessing }
FylgjaMigrationEngine >> noTracing [
	tracing := tracing noTracing
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> originalModel [

	^ self
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

	| derivative |
	derivative := self derivative.
	
	^ derivative manageApplicationCycleAndProduceResult: [ 
		  self
			  produce: aProvenanceEntity
			  croppingRelationsWith: aBlock
			  into: aDestinationContext
			  using: derivative ]
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
	lookup := aModifiedFylgjaMigrationEngine
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
FylgjaMigrationEngine >> produceWithContextualizedProvenance: elementRelation croppingRelationsWith: aBlock into: aDestinationContext using: aModifiedFylgjaMigrationEngine [

	| destinationContextRelation resultingRelation lookup destinationModel |
	destinationContextRelation := aModifiedFylgjaMigrationEngine 
		                              readEntitysContextualizingRelation:
		                              aDestinationContext.
	destinationModel := aModifiedFylgjaMigrationEngine 
		                    selectDerivativeModelFor: aDestinationContext.
	lookup := self
		          lookupContextFor: elementRelation
		          toContext: destinationContextRelation
		          model: destinationModel
		          using: aModifiedFylgjaMigrationEngine.


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
