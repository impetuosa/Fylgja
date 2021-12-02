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

	^ mapspace
		  lookupRulesForMapping: anAlcixFunction
		  toContext: aMOClass
		  model: (self selectDestinationModelFor: aMOClass)
]

{ #category : #'as yet unclassified' }
FylgjaModel >> lookupRulesForProducing: anAlcixFunction toContext: aMOClass [

	^ mapspace
		  lookupRulesForProducing: anAlcixFunction
		  toContext: aMOClass
		  model: (self selectDestinationModelFor: aMOClass)
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

	| rules |
	rules := self
		         lookupRulesForProducing: anAlcixFunction
		         toContext: aMOJavaClass.
	rules ifEmpty: [ NotFound signal: 'No producing rule found ' ].
	^ rules first applyTo: anAlcixFunction context: aMOJavaClass
]

{ #category : #'as yet unclassified' }
FylgjaModel >> producers [
	^ mapspace allProducers
]

{ #category : #'as yet unclassified' }
FylgjaModel >> selectDestinationModelFor: aMOClass [

	^ models detect: [ :d | d entities includes: aMOClass ]
]
