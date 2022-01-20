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
FylgjaDerivativeModel >> produce: aProvenanceEntity into: aContextDestination [

	^ fylgja produce: aProvenanceEntity into: aContextDestination using: self
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> readerFor: aModelEntity [

	^ (FylgjaResolver readerOn: self for: aModelEntity) resolve
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> selectDestinationModelFor: aDestinationContext [
	^ derivativeModels
		  detect: [ :d | d entities includes: aDestinationContext ]
		  ifNone: [ 
			  | model |
			  model := (fylgja selectDestinationModelFor: aDestinationContext) derivative.
			  derivativeModels add: model.
			  model ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivativeModel >> writerFor: aProvenanceEntity inContextOf: aDestinationContext do: anUpdatingBlock [

	^ (self selectDestinationModelFor: aDestinationContext) writer
		  updaterFor: aDestinationContext
		  with: aProvenanceEntity
		  do: anUpdatingBlock
]
