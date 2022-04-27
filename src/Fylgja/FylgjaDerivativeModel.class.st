Class {
	#name : #FylgjaDerivativeModel,
	#superclass : #Object,
	#instVars : [
		'fylgja',
		'derivativeModels',
		'deferredMapping',
		'mrs',
		'migrationRuleSpace'
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
FylgjaDerivativeModel >> bind: aMOObjectObjectRelation croppingRelationsWith: aFullBlockClosure intoDestinationWriter: aMOExpressionWriter lookUp: aFylgjaLookUpContext [ 
	self shouldBeImplemented.
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
FylgjaDerivativeModel >> forceMap [

	^ fylgja forceMapStubs: self
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> forceMapReferences: aCollection [

	| refModel |
	refModel := (aCollection select: [ :a | a isFylgjaStub ]) groupedBy: [ 
		            :a | self selectDerivativeModelFor: a ].

	refModel keysAndValuesDo: [ :model :references | 
		fylgja
			forceReMappingRuleOverStubs: references
			contextModel: model
			using: self ]
]

{ #category : #accessing }
FylgjaDerivativeModel >> fylgja: aFylgjaModel [

	fylgja := aFylgjaModel.
	migrationRuleSpace := aFylgjaModel migrationRuleSpace copySpace
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> initialize [

	super initialize.
	derivativeModels := OrderedCollection new
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
FylgjaDerivativeModel >> mapEntity: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aFullBlockClosure usingWriter: aWriter lookUp: aFylgjaLookUpContext [

	^ fylgja
		  mapEntity: aDestinationEntity
		  as: aCandidateRelation
		  croppingRelationsWith: aFullBlockClosure
		  usingWriter: aWriter
		  lookUp: aFylgjaLookUpContext
		  using: self
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
FylgjaDerivativeModel >> originalModel [

	^ fylgja originalModel
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

	| result |

	result := fylgja
		          produce: aProvenanceEntity
		          croppingRelationsWith: [ :a | a ]
		          into: aContextDestinationEntity
		          using: self.

	^ self produceResult: result
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> produceResult: anObject [
	" 
		Once a result is produced, means that a chain of migration has finished. 
		Time to process bindings 
	"
	self processDeferredMappings.
	^ FylgjaDerivationResult new
		  derivative: self;
		  result: anObject;
		  yourself
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

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> writerFor: aProvenanceEntity inContextOf: aDestinationContext do: anUpdatingBlock [

	| writer destinationEntity |
	writer := (self selectDerivativeModelFor: aDestinationContext)
		          writer.
	destinationEntity := writer
		                     updaterFor: aDestinationContext
		                     with: aProvenanceEntity
		                     do: anUpdatingBlock.
	writer populateAnchor.
	^ destinationEntity
]
