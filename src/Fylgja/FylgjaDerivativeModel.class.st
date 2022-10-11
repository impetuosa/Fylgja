Class {
	#name : #FylgjaDerivativeModel,
	#superclass : #Object,
	#instVars : [
		'fylgja',
		'derivativeModels',
		'deferredMapping',
		'mrs',
		'migrationRuleSpace',
		'state',
		'errors'
	],
	#category : #'Fylgja-Model'
}

{ #category : #initialization }
FylgjaDerivativeModel >> addDeferredMapping: aMOStClass to: aMOStClass2 [
 
	(self deferredMapping
		 at: aMOStClass
		 ifAbsentPut: [ OrderedCollection new ]) add: aMOStClass2.
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> allNewEntities [
	^ self derivativeModels flatCollect: #entities 
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> bindCandidateless [

	fylgja bindCandidateless: self
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> bindCandidateless: aFylgjaDerivativeModel [

	^ fylgja bindCandidateless: aFylgjaDerivativeModel
]

{ #category : #accessing }
FylgjaDerivativeModel >> deferredMapping [
	^ deferredMapping ifNil: [ deferredMapping := Dictionary new  ]
]

{ #category : #initialization }
FylgjaDerivativeModel >> derivative [

	^ FylgjaDerivativeModel new
		  fylgja: self;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> derivativeModelFor: aMOModel [

	^ self derivativeModels
		  detect: [ :dm | dm isDerivedFrom: aMOModel ]
		  ifNone: [ 
			  | dm |
			  dm := aMOModel derivative.
			  self derivativeModels add: dm.
			  dm ]
]

{ #category : #accessing }
FylgjaDerivativeModel >> derivativeModels [
	^ derivativeModels
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> errors [

	^ errors ifNil: [ errors := OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> finalizeFylgja [

	derivativeModels do: [ :dm | dm finalizeMoxing ].
	derivativeModels removeAll.
	migrationRuleSpace finalizeFylgja
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> forceMap [

	^ fylgja forceMapStubs: self
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> forceMapReferences: aCollection [

	| refModel |
	refModel := ((aCollection flatCollect: #value) select: [ :a | 
		             a isFylgjaStub ]) groupedBy: [ :a | 
		            self selectDerivativeModelFor: a ].

	refModel keysAndValuesDo: [ :model :references | 
		fylgja
			forceReMappingRuleOverStubs: references
			contextModel: model
			using: self ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> forceMapStubs: aFylgjaDerivativeModel [

	^ fylgja forceMapStubs: aFylgjaDerivativeModel
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> forceReMappingRuleOverStubs: aCollection contextModel: aMOModelDerivative using: aFylgjaDerivativeModel [

	^ fylgja
		  forceReMappingRuleOverStubs: aCollection
		  contextModel: aMOModelDerivative
		  using: aFylgjaDerivativeModel
]

{ #category : #accessing }
FylgjaDerivativeModel >> fylgja: aFylgjaModel [

	fylgja := aFylgjaModel.
	migrationRuleSpace := aFylgjaModel migrationRuleSpace copySpace
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> initialize [

	super initialize.
	derivativeModels := OrderedCollection new.
	state := #Success
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> installAllDerivativeModels [

	^ fylgja models collect: [ :m | self derivativeModelFor: m ]
]

{ #category : #testing }
FylgjaDerivativeModel >> isDerivativeEntity: anEntity [
	 | model |
	model := self selectDerivativeModelFor: anEntity ifNone: [ ^ false ].
	^ model exclusivelyincludes: anEntity 

]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> isFailure [

	^ self isSuccessful not
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> isSuccessful [

	^ state = #Success
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> lookupContextFor: aMODeclarationStructuralRelation toContext: aMODeclarationStructuralRelation2 model: aMOModelDerivative [

	^ fylgja
		  lookupContextFor: aMODeclarationStructuralRelation
		  toContext: aMODeclarationStructuralRelation2
		  model: aMOModelDerivative
		  using: self
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> lookupContextFor: aMODeclarationStructuralRelation toContext: aMODeclarationStructuralRelation2 model: aMOModelDerivative using: aFylgjaDerivativeModel [

	^ fylgja
		  lookupContextFor: aMODeclarationStructuralRelation
		  toContext: aMODeclarationStructuralRelation2
		  model: aMOModelDerivative
		  using: aFylgjaDerivativeModel
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> manageApplicationCycleAndProduceResult: aBlock [

	| result changes amountChanges |
	" 
	The application of rules happens *allways* in a derivative model. 
	The derivative model represents a transactional state. 
	The application of the production directive responds to the following steps: 
	
	1- Apply the production directive
	2- Process deferredMapping rules
	3- Apply the binding directive over all the freshly produced bindable elements.
	4- Inform the models that the cycle has been accepted. 
	5- Produce a result object with the main produced entity.
	 
	"
	[ 
	result := aBlock value.
	
	[
		self processDeferredMappings.
		amountChanges := self deferredMapping size. 
		self processBindings.
		self processLinking.
 		amountChanges = self deferredMapping size ifFalse: [ self halt ].
	] doWhileFalse: [ 
		" fixed point ".
		
		amountChanges = self deferredMapping size
		
	].

	self noteSuccess ]
		on: Error
		do: [ :e | 
			self noteError: e.
			e pass ].

	^ FylgjaDerivationResult new
		  derivative: self;
		  result: result;
		  yourself
]

{ #category : #accessing }
FylgjaDerivativeModel >> map: aProvenanceEntity to: aDestinationEntity [

	^ fylgja map: aProvenanceEntity to: aDestinationEntity using: self
]

{ #category : #accessing }
FylgjaDerivativeModel >> map: aProvenanceEntity to: aDestinationEntity context: aContext [

	^ fylgja
		  map: aProvenanceEntity
		  to: aDestinationEntity
		  using: self
		  atContext: aContext
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> map: aMOPrimitiveType to: aMOClass using: aFylgjaDerivativeModel atContext: aMORootDeclaration [

	^ fylgja
		  map: aMOPrimitiveType
		  to: aMOClass
		  using: aFylgjaDerivativeModel
		  atContext: aMORootDeclaration
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> mapEntity: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aFullBlockClosure usingWriter: aWriter lookUp: aFylgjaLookUpContext [

	| resp |
	resp := fylgja
		        mapEntity: aDestinationEntity
		        as: aCandidateRelation
		        croppingRelationsWith: aFullBlockClosure
		        usingWriter: aWriter
		        lookUp: aFylgjaLookUpContext
		        using: self.
	((aCandidateRelation read: aDestinationEntity) isFylgjaStub or: [ 
		 resp isPrimitiveType ]) ifFalse: [ 
		aWriter updateDeclarationUnitDependencies: aDestinationEntity ].
	^ resp
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> mapEntity: aMOTypeReference as: aMODeclarationStructuralRelation croppingRelationsWith: aFullBlockClosure usingWriter: aMOExpressionWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ fylgja
		  mapEntity: aMOTypeReference
		  as: aMODeclarationStructuralRelation
		  croppingRelationsWith: aFullBlockClosure
		  usingWriter: aMOExpressionWriter
		  lookUp: aFylgjaLookUpContext
		  using: aFylgjaDerivativeModel
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> mapOrFail: aMOAttributeAccessor to: aMOAttributeAccessor2 using: aFylgjaDerivativeModel [

	^ fylgja
		  mapOrFail: aMOAttributeAccessor
		  to: aMOAttributeAccessor2
		  using: aFylgjaDerivativeModel
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> migrate: aProvenanceEntityRelation croppingRelationsWith: aBlock intoDestinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext [

	^ fylgja
		  migrate: aProvenanceEntityRelation
		  croppingRelationsWith: aBlock
		  intoDestinationWriter: aDestinationWriter
		  lookUp: aFylgjaLookUpContext
		  using: self
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> migrate: aMODeclarationStructuralRelation croppingRelationsWith: aFullBlockClosure intoDestinationWriter: aMODeclarationUnitWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ fylgja
		  migrate: aMODeclarationStructuralRelation
		  croppingRelationsWith: aFullBlockClosure
		  intoDestinationWriter: aMODeclarationUnitWriter
		  lookUp: aFylgjaLookUpContext
		  using: aFylgjaDerivativeModel
]

{ #category : #accessing }
FylgjaDerivativeModel >> migrationRuleSpace [
	^ migrationRuleSpace
]

{ #category : #accessing }
FylgjaDerivativeModel >> models [

	^ self derivativeModels
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> mrsFor: aDestinationContext [

	^ fylgja mrsFor: aDestinationContext using: self
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> mrsFor: aMODeclarationUnit using: aFylgjaDerivativeModel [

	^ fylgja mrsFor: aMODeclarationUnit using: aFylgjaDerivativeModel
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> noteError: e [

	state := #Failure.
	self errors add: e
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> noteSuccess [
	" By default the model is a successfull model. "
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> originalModel [

	^ fylgja originalModel
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> processBindings [
	self bindCandidateless. 
	self forceMap.	


]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> processDeferredMappings [

	| ready |
	ready := OrderedCollection new.

	self deferredMapping associationsDo: [ :assoc | 
		assoc value do: [ :dest | 
			dest parentForContext ifNotNil: [ ready add: assoc key -> dest ] ] ].

	ready do: [ :re | 
		[ 
		fylgja mapOrFail: re key to: re value using: self.
		(self deferredMapping at: re key) remove: re value ]
			on: FylgjaMapError
			do: [ :e | " self halt" ] ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> processLinking [

	^ self derivativeModels do: [ :a | a link ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> produce: aMOAlceQuery applying: aFylgjaProductionRule croppingRelationsWith: aFullBlockClosure into: aMORootDeclaration using: aFylgjaDerivativeModel [

	^ fylgja
		  produce: aMOAlceQuery
		  applying: aFylgjaProductionRule
		  croppingRelationsWith: aFullBlockClosure
		  into: aMORootDeclaration
		  using: aFylgjaDerivativeModel
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> produce: aProvenanceEntity applying: aRule into: aContextDestinationEntity [

	^ self manageApplicationCycleAndProduceResult: [ 
		  fylgja
			  produce: aProvenanceEntity
			  applying: aRule
			  croppingRelationsWith: [ :a | a ]
			  into: aContextDestinationEntity
			  using: self ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> produce: aProvenanceEntity croppingRelationsWith: aFullBlockClosure into: aDestinationContext [

	^ fylgja
		  produce: aProvenanceEntity
		  croppingRelationsWith: aFullBlockClosure
		  into: aDestinationContext
		  using: self
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> produce: aMODeclarationUnit croppingRelationsWith: aFullBlockClosure into: aMOPackage using: aFylgjaDerivativeModel [

	^ fylgja
		  produce: aMODeclarationUnit
		  croppingRelationsWith: aFullBlockClosure
		  into: aMOPackage
		  using: aFylgjaDerivativeModel
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> produce: aProvenanceEntity into: aContextDestinationEntity [
	^ self manageApplicationCycleAndProduceResult: [ 
		  fylgja
			  produce: aProvenanceEntity
			  croppingRelationsWith: [ :a | a ]
			  into: aContextDestinationEntity
			  using: self ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> produceWithContextualizedProvenance: aProvenanceEntity croppingRelationsWith: aFullBlockClosure into: aDestinationContext [

	^ fylgja
		  produceWithContextualizedProvenance: aProvenanceEntity
		  croppingRelationsWith: aFullBlockClosure
		  into: aDestinationContext
		  using: self
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> produceWithContextualizedProvenance: aMODeclarationStructuralRelation croppingRelationsWith: aFullBlockClosure into: aMOPackage using: aFylgjaDerivativeModel [

	^ fylgja
		  produceWithContextualizedProvenance:
		  aMODeclarationStructuralRelation
		  croppingRelationsWith: aFullBlockClosure
		  into: aMOPackage
		  using: aFylgjaDerivativeModel
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> readEntity: anEntity [

	^ (self isDerivativeEntity: anEntity)
		  ifTrue: [ anEntity ]
		  ifFalse: [ (self readerFor: anEntity) read: anEntity ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> readEntitysContextualizingRelation: anEntity [

	^ (self isDerivativeEntity: anEntity)
		  ifTrue: [ 
			  | relation |
			  " This code should not be here :( "
			  anEntity parent ifNil: [ 
				  ^ self readRelation:
					    (MODeclarationStructuralRelation nullRelationTo: anEntity) ].
			  relation := anEntity parent allRelations select: [ :a | 
				              a to = anEntity ].
			  self assert: relation size <= 1.
			  relation := relation
				              ifEmpty: [ 
				              MODeclarationStructuralRelation nullRelationTo:
					              anEntity ]
				              ifNotEmpty: [ relation first ].

			  self readRelation: relation ]
		  ifFalse: [ 
			  (self readerFor: anEntity) readEntitysContextualizingRelation:
				  anEntity ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> readRelation: aRelation [

	^ (self isDerivativeEntity: aRelation to)
		  ifTrue: [ aRelation ]
		  ifFalse: [ (self readerFor: aRelation to) readRelation: aRelation ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> readerFor: aModelEntity [

	^ (FylgjaResolver readerOn: self for: aModelEntity) resolve
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> selectDerivativeModelFor: aDestinationContext [

	^ self selectDerivativeModelFor: aDestinationContext ifNone: [ 
		  | model |
		  model := (fylgja selectDerivativeModelFor: aDestinationContext)
			           derivative.
		  self derivativeModels add: model.
		  model ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> selectDerivativeModelFor: aDestinationContext ifNone: aBlock [

	^ self derivativeModels
		  detect: [ :d | d includes: aDestinationContext ]
		  ifNone: [ aBlock value ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> stubReferencesTo: aProvenanceEntity from: aDestinationModel [

	^ aDestinationModel entities select: [ :a | 
		  (a isKindOf: FylgjaCandidateStub) and: [ 
			  a candidate = aProvenanceEntity ] ]
]
