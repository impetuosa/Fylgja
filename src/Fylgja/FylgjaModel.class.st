Class {
	#name : #FylgjaModel,
	#superclass : #Object,
	#instVars : [
		'mapspace',
		'models'
	],
	#category : #'Fylgja-Model'
}

{ #category : #adding }
FylgjaModel >> addModel: aMOJavaProject [

	self mapspace registerSpace: aMOJavaProject name.
	^ self models add: aMOJavaProject.
	
]

{ #category : #'as yet unclassified' }
FylgjaModel >> derivative [

	^ FylgjaDerivativeModel new
		  fylgja: self;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaModel >> get: anAlcixFunction for: aMOJavaClass [

	| rules |
	rules := self
		         lookupRulesForMapping: anAlcixFunction
		         toContext: aMOJavaClass.
	rules ifEmpty: [ NotFound signal: 'No mapping rule found ' ].
	^ rules first applyTo: anAlcixFunction context: aMOJavaClass
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

{ #category : #'as yet unclassified' }
FylgjaModel >> lookupRulesForMapping: anAlcixFunction toContext: aMOClass [

	^ self
		  lookupRulesForMapping: anAlcixFunction
		  toContext: aMOClass
		  model: (self selectDestinationModelFor: aMOClass)
]

{ #category : #'as yet unclassified' }
FylgjaModel >> lookupRulesForMapping: anAlcixFunction toContext: aMOClass model: aModel [ 

	^ mapspace
		  lookupRulesForMapping: anAlcixFunction
		  toContext: aMOClass
		  model: aModel
]

{ #category : #'as yet unclassified' }
FylgjaModel >> lookupRulesForProducing: anAlcixFunction toContext: aMOClass [

	^ self
		  lookupRulesForProducing: anAlcixFunction
		  toContext: aMOClass
		  model: (self selectDestinationModelFor: aMOClass)
]

{ #category : #'as yet unclassified' }
FylgjaModel >> lookupRulesForProducing: anAlcixFunction toContext: aMOClass destinationModel: destinationModel [

	^ self
		  lookupRulesForProducing: anAlcixFunction
		  toContext: aMOClass
		  model: destinationModel
]

{ #category : #'as yet unclassified' }
FylgjaModel >> lookupRulesForProducing: anAlcixFunction toContext: aMOClass model: aModel [ 

	^ mapspace
		  lookupRulesForProducing: anAlcixFunction
		  toContext: aMOClass
		  model: aModel
]

{ #category : #accessing }
FylgjaModel >> mapspace [

	^ mapspace ifNil: [ mapspace := FylgjaMapSpace new ]
]

{ #category : #'as yet unclassified' }
FylgjaModel >> models [ 

	^ models ifNil: [ models := Set new ]
]

{ #category : #'as yet unclassified' }
FylgjaModel >> produce: anAlcixFunction into: aMOJavaClass [

	| result derivative |
	derivative := self derivative.
	result := self
		          produce: anAlcixFunction
		          into: aMOJavaClass
		          using: derivative.
	^ FylgjaDerivationResult new
		  derivative: derivative;
		  result: result;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaModel >> produce: anAlcixFunction into: aMOJavaClass using: aFylgjaOrDerivativeModel [

	| rules |
	rules := self
		         lookupRulesForProducing: anAlcixFunction
		         toContext: aMOJavaClass
		         destinationModel:
		         (aFylgjaOrDerivativeModel selectDestinationModelFor:
			          aMOJavaClass).

	rules ifEmpty: [ NotFound signal: 'No producing rule found ' ].
	rules size > 1 ifTrue: [ ^ self error: 'Rule selection colision' ].

	^ rules first
		  applyTo: anAlcixFunction
		  context: aMOJavaClass
		  using: aFylgjaOrDerivativeModel
]

{ #category : #'as yet unclassified' }
FylgjaModel >> producers [
	^ mapspace allProducers
]

{ #category : #'as yet unclassified' }
FylgjaModel >> selectDestinationModelFor: aMOClass [

	^ models detect: [ :d | d entities includes: aMOClass ]
]
