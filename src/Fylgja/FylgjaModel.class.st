Class {
	#name : #FylgjaModel,
	#superclass : #Object,
	#instVars : [
		'mooseModel',
		'destinations',
		'mapspace'
	],
	#category : #'Fylgja-Model'
}

{ #category : #adding }
FylgjaModel >> addDestination: aMOJavaProject [

	self mapspace registerSpace: aMOJavaProject name.
	^ self destinations add: aMOJavaProject.
	
]

{ #category : #'as yet unclassified' }
FylgjaModel >> destinations [

	^ destinations ifNil: [ destinations := Set new ]
]

{ #category : #'as yet unclassified' }
FylgjaModel >> get: anAlcixFunction for: aMOJavaClass [

	^ (self selectMappingContextFor: aMOJavaClass) get: anAlcixFunction
]

{ #category : #'as yet unclassified' }
FylgjaModel >> getOrProduce: anAlcixFunction for: aMOJavaClass [

	^ (self selectMappingContextFor: aMOJavaClass)
		  get: anAlcixFunction
		  ifAbsent: [ self tryProduce: anAlcixFunction for: aMOJavaClass ]
]

{ #category : #'as yet unclassified' }
FylgjaModel >> getOrProduce: anElement for: aMOClass ifNotProducerAvailable: aFullBlockClosure [

	^ (self selectMappingContextFor: aMOClass)
		  get: anElement
		  ifAbsent: [ 
			  self
				  tryProduce: anElement
				  for: aMOClass
				  ifNotProducerAvailable: aFullBlockClosure ]
]

{ #category : #accessing }
FylgjaModel >> initialize [

	super initialize. 
	mapspace := FylgjaMapSpace new.
]

{ #category : #'as yet unclassified' }
FylgjaModel >> installProducer: aTranslator from: anAlcixFunction to: aMOJavaClass [

	(self selectMappingContextForInstalling: aMOJavaClass)
		installProducer: aTranslator
		from: anAlcixFunction.

	
]

{ #category : #accessing }
FylgjaModel >> mapspace [

	^ mapspace ifNil: [ mapspace := FylgjaMapSpace new ]
]

{ #category : #accessing }
FylgjaModel >> mooseModel: anAlcixModel [ 
	mooseModel := anAlcixModel 
]

{ #category : #accessing }
FylgjaModel >> origin [
	^ mooseModel 
]

{ #category : #'as yet unclassified' }
FylgjaModel >> producers [
	^ mapspace allProducers
]

{ #category : #'as yet unclassified' }
FylgjaModel >> selectDestinationModelFor: aMOClass [

	^ destinations detect: [ :d | d entities includes: aMOClass ]
]

{ #category : #'as yet unclassified' }
FylgjaModel >> selectMappingContextFor: aMOJavaClass [

	^ mapspace mapspaceFor: aMOJavaClass anchor
]

{ #category : #'as yet unclassified' }
FylgjaModel >> selectMappingContextForInstalling: aMOClass [

	^ mapspace getOrCreateMapspaceFor: aMOClass anchor
]

{ #category : #'as yet unclassified' }
FylgjaModel >> tryProduce: anAlcixFunction for: aMOClass [

	^ self
		  tryProduce: anAlcixFunction
		  for: aMOClass
		  ifNotProducerAvailable: [ 
			  NotFound signal:
				  'No code producer has been found for given element ' ]
]

{ #category : #'as yet unclassified' }
FylgjaModel >> tryProduce: anAlcixFunction for: aMOClass ifNotProducerAvailable: aBlock [

	^ ((self selectMappingContextFor: aMOClass)
		   producerFor: anAlcixFunction
		   ifNone: [ aBlock value ])
		  produce: anAlcixFunction
		  into: aMOClass
		  destination: (self selectDestinationModelFor: aMOClass)
]
