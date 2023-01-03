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
		destinationContext to parent ifNotNil: [ 
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
				using: aFylgjaDerivativeModel ] ]
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
FylgjaMigrationEngine >> closerContainer: aMOJavaClass [

	^ FylgjaCloserContainerResolver new resolve: aMOJavaClass
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
		reject: [ :stub | 
			stub provenance to isNil or: [ 
				stub parent parent isNil and: [ stub parent anchor isNil ] ] ]
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
FylgjaMigrationEngine >> installStub: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock usingWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	| candidate |
	(aCandidateRelation read: aDestinationEntity) ifNil: [ 
		candidate := aDestinationWriter writeFylgjaCandidateStub: [ :a | 
			             a parent: aDestinationEntity.
			             a provenance: aCandidateRelation.
			             a referee: aCandidateRelation to ].
		aCandidateRelation write: candidate to: aDestinationEntity ].
	^ aDestinationEntity
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> lookupContextFor: aProvenanceEntity toContext: aDestinationContext model: aMOModel using: aMOModelDerivative [

	^ aMOModelDerivative migrationRuleSpace
		  lookupContextFor: aProvenanceEntity
		  toContext: aDestinationContext
		  model: aMOModel
]

{ #category : #accessing }
FylgjaMigrationEngine >> map: aProvenanceEntity to: aDestinationEntity [

	| derivative |
	derivative := self derivative.

	self map: aProvenanceEntity to: aDestinationEntity using: derivative.


	^ derivative
]

{ #category : #accessing }
FylgjaMigrationEngine >> map: aMOPrimitiveType to: aMOJavaClass context: aMOModel [

	^ self
		  map: aMOPrimitiveType
		  to: aMOJavaClass
		  using: self
		  atContext: aMOModel
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> map: aProvenanceEntity to: aDestinationEntity context: context mapping: aCollection [

	^ self
		  map: aProvenanceEntity
		  to: aDestinationEntity
		  using: self
		  atContext: context
		  mapping: aCollection
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

	^ self
		  map: aProvenanceEntity
		  to: aDestinationEntity
		  using: aModifiedFylgjaMigrationEngine
		  atContext: context
		  mapping: #(  )
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> map: aProvenanceEntity to: aDestinationEntity using: aModifiedFylgjaMigrationEngine atContext: context mapping: aMappingCollection [

	^ FylgjaMappingInstaller new
		  context: context;
		  map: aProvenanceEntity
		  with: aDestinationEntity
		  using: aMappingCollection;
		  installInto: aModifiedFylgjaMigrationEngine
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> map: aProvenanceEntity to: aDestinationEntity using: aModifiedFylgjaMigrationEngine or: aBlock [

	self assert: aProvenanceEntity isDeclaration.
	self assert: aDestinationEntity isDeclaration.

	(aDestinationEntity parentForContext isNil or: [ 
		 aDestinationEntity anchor isNil ])
		ifTrue: [ aBlock value ]
		ifFalse: [ 
			(self
				 map: aProvenanceEntity
				 to: aDestinationEntity
				 using: aModifiedFylgjaMigrationEngine
				 atContext: (self
						  resolveMappingContextFor: aDestinationEntity
						  using: aModifiedFylgjaMigrationEngine)) setAsEngine ].



	^ aModifiedFylgjaMigrationEngine
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> map: aMOAlceQuery toAll: aCollection using: aFylgjaDerivativeModel [

	| flat |
	" When mapping to many we use each target's parent as context "
	flat := aCollection flatCollect: [ :a | 
		        a isArray
			        ifTrue: [ a ]
			        ifFalse: [ { a } ] ].
	(flat anySatisfy: [ :a | a parent isNil or: [ a anchor isNil ] ]) 
		ifTrue: [ ^ self ].

	flat do: [ :t | 
		self
			map: aMOAlceQuery
			to: t
			using: aFylgjaDerivativeModel
			atContext: (self closerContainer: t) ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> mapEntity: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock usingWriter: aWriter lookUp: aLookupContext using: aModifiedFylgjaMigrationEngine [

	| rules partialResult rule |
	(aCandidateRelation read: aDestinationEntity) ifNotNil: [ :a | 
		a isFylgjaStub ifFalse: [ ^ aDestinationEntity ] ].
	aCandidateRelation to ifNil: [ ^ aDestinationEntity ].

	rules := aLookupContext
		         lookupRulesForBinding: aDestinationEntity
		         with: aCandidateRelation
		         using: aWriter.


	rules ifEmpty: [ 
		^ self
			  installStub: aDestinationEntity
			  as: aCandidateRelation
			  croppingRelationsWith: aBlock
			  usingWriter: aWriter
			  lookUp: aLookupContext
			  using: aModifiedFylgjaMigrationEngine ].


	rules size > 1 ifTrue: [ self halt ].
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
FylgjaMigrationEngine >> produce: aProvenanceEntityRelation applying: aRule croppingRelationsWith: aBlock destinationWriter: aWriter lookUp: aLookupContext using: aModifiedFylgjaMigrationEngine [

	| relation partialResult |
	relation := aModifiedFylgjaMigrationEngine readRelation:
		            aProvenanceEntityRelation.
	
	partialResult := aRule
		                 applyTo: relation
		                 croppingRelationsWith: aBlock
		                 destinationWriter: aWriter
		                 lookUp: aLookupContext
		                 using: aModifiedFylgjaMigrationEngine.

	self
		trace: relation
		to: aRule
		produced: partialResult
		using: aModifiedFylgjaMigrationEngine.
	^ partialResult
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> produce: aProvenanceEntity applying: aRule croppingRelationsWith: aBlock into: aDestinationContext [

	| derivative |
	derivative := self derivative.

	^ derivative manageApplicationCycleAndProduceResult: [ 
		  self
			  produce: aProvenanceEntity
			  applying: aRule
			  croppingRelationsWith: aBlock
			  into: aDestinationContext
			  using: derivative ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> produce: aProvenanceEntity applying: aRule croppingRelationsWith: aBlock into: aDestinationContext using: aModifiedFylgjaMigrationEngine [

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
				                     applying: aRule
				                     croppingRelationsWith: aBlock
				                     destinationWriter: destinationWriter
				                     lookUp: lookup
				                     using: aModifiedFylgjaMigrationEngine ].

	^ resultingRelation
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> produce: aProvenanceEntity applying: aRule into: aDestinationContext [

	^ self
		  produce: aProvenanceEntity
		  applying: aRule
		  croppingRelationsWith: [ :a | a ]
		  into: aDestinationContext
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> produce: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aWriter lookUp: aLookupContext using: aModifiedFylgjaMigrationEngine [

	| rules relation partialResult rule |
	relation := aModifiedFylgjaMigrationEngine readRelation:
		            aProvenanceEntityRelation.

	rules := aLookupContext
		         lookupRulesForProducing: relation
		         forWriting: aWriter writingType
		         with: aWriter.

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
FylgjaMigrationEngine >> resolveMappingContextFor: aDestinationEntity using: aModifiedFylgjaMigrationEngine [

	^ aDestinationEntity existsOnlyInParentContext
		  ifTrue: [ aDestinationEntity parent ]
		  ifFalse: [ 
			  (aModifiedFylgjaMigrationEngine selectDerivativeModelFor:
				   aDestinationEntity) root ] 
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> selectDerivativeModelFor: aDestinationContext [

	^ models detect: [ :d | d includes: aDestinationContext ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> trace: aProvenanceEntity to: aRule produced: partialResult using: aModifiedFylgjaMigrationEngine [

	((aProvenanceEntity respondsTo: #name) and: [ 
		 aProvenanceEntity name = #Conversion ]) ifTrue: [ self halt ].
	tracing trace: aProvenanceEntity to: aRule produced: partialResult.

	partialResult isCollection ifTrue: [ 
		self
			map: aProvenanceEntity to
			toAll: partialResult
			using: aModifiedFylgjaMigrationEngine.
		^ self ].
	partialResult isDeclaration ifTrue: [ 
		self
			map: aProvenanceEntity to
			to: partialResult
			using: aModifiedFylgjaMigrationEngine.
		^ self ].

	partialResult isDeclarationUnit ifTrue: [ 
		| type |
		type := partialResult types
			        detect: [ :t | t name = aProvenanceEntity to name ]
			        ifNone: [ ^ self ].
		self
			map: aProvenanceEntity to
			to: type
			using: aModifiedFylgjaMigrationEngine ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationEngine >> traces [
	^ tracing traces
]
