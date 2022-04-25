Class {
	#name : #FylgjaDerivativeModel,
	#superclass : #Object,
	#instVars : [
		'fylgja',
		'derivativeModels',
		'deferredMapping'
	],
	#category : #'Fylgja-Model'
}

{ #category : #initialization }
FylgjaDerivativeModel >> addDeferredMapping: aMOStClass to: aMOStClass2 [
	self processDeferredMappings. 
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

{ #category : #accessing }
FylgjaDerivativeModel >> fylgja: aFylgjaModel [ 
	fylgja := aFylgjaModel
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> initialize [

	super initialize.
	derivativeModels := OrderedCollection new
]

{ #category : #testing }
FylgjaDerivativeModel >> isDerivativeEntity: anEntity [
	 | model |
	model := self selectDerivativeModelFor: anEntity ifNone: [ ^ false ].
	^ model exclusivelyincludes: anEntity 

]

{ #category : #accessing }
FylgjaDerivativeModel >> lookUpContext: anEntity [

	^ fylgja lookUpContext: anEntity using: self
]

{ #category : #accessing }
FylgjaDerivativeModel >> map: aProvenanceEntity to: aDestinationEntity [

	^ fylgja map: aProvenanceEntity to: aDestinationEntity using: self
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
FylgjaDerivativeModel >> migrate: aProvenanceEntityRelation croppingRelationsWith: aBlock intoDestinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext [

	^ fylgja
		  migrate: aProvenanceEntityRelation
		  croppingRelationsWith: aBlock
		  intoDestinationWriter: aDestinationWriter
		  lookUp: aFylgjaLookUpContext
		  using: self
]

{ #category : #accessing }
FylgjaDerivativeModel >> migrationRuleSpace [
	^ fylgja migrationRuleSpace
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
		(self deferredMapping at: ready first key) remove:  re value ]
			on: Error
			do: [ :e |" self halt" ] ]
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
FylgjaDerivativeModel >> produce: aProvenanceEntity into: aContextDestinationEntity [

	^ FylgjaDerivationResult new
		  derivative: self;
		  result: (fylgja
				   produce: aProvenanceEntity
				   croppingRelationsWith: [ :a | a ]
				   into: aContextDestinationEntity
				   using: self);
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
			  relation := anEntity parent allRelations select: [ :a | 
				              a to = anEntity ].
			  self assert: relation size = 1.
			  self readRelation: relation first ]
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
