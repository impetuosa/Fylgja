Class {
	#name : #FylgjaDerivativeModel,
	#superclass : #Object,
	#instVars : [
		'fylgja',
		'derivativeModels'
	],
	#category : #'Fylgja-Model'
}

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> allNewEntities [
	^ derivativeModels flatCollect: #entities 
]

{ #category : #accessing }
FylgjaDerivativeModel >> derivativeModels [
	^ derivativeModels
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

	self selectDerivativeModelFor: anEntity ifNone: [ ^ false ].
	^ true
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> map: aProvenanceReferenceEntity into: aDestinationContext [  
	^ fylgja map: aProvenanceReferenceEntity into: aDestinationContext using: self
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> migrate: aProvenanceEntity into: aDestinationContext [
	^ aProvenanceEntity isReference
		  ifTrue: [ self map: aProvenanceEntity into: aDestinationContext ]
		  ifFalse: [ 
		  self produce: aProvenanceEntity into: aDestinationContext ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> migrate: aProvenanceEntity intoDestinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext [

	^ fylgja
		  migrate: aProvenanceEntity
		  intoDestinationWriter: aDestinationWriter
		  lookUp: aFylgjaLookUpContext
		  using: self
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> produce: aProvenanceEntity into: aContextDestination [

	self halt:
		' should be using produce: aProvenanceEntity destinationWriter: aWriter lookUp: aLookupContext using: aModifiedFylgjaMigrationEngine'.
	^ fylgja
		  produce: aProvenanceEntity
		  into: aContextDestination
		  using: self
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> readEntity: anEntity [

	^ (self isDerivativeEntity: anEntity)
		  ifTrue: [ anEntity ]
		  ifFalse: [ (self readerFor: anEntity) read: anEntity ]
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
		  derivativeModels add: model.
		  model ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> selectDerivativeModelFor: aDestinationContext ifNone: aBlock [

	^ derivativeModels
		  detect: [ :d | d includes: aDestinationContext ]
		  ifNone: [ aBlock value ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> trace: aProvenanceEntity to: aRule produced: partialResult [
	fylgja trace: aProvenanceEntity to: aRule produced: partialResult
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
