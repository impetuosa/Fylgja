Class {
	#name : #FylgjaModel,
	#superclass : #Object,
	#instVars : [
		'mooseModel',
		'destinations',
		'translators',
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

{ #category : #accessing }
FylgjaModel >> initialize [

	super initialize. 
	translators := Dictionary new.
	mapspace := FylgjaMapSpace new.
]

{ #category : #'as yet unclassified' }
FylgjaModel >> installTranslation: aTranslator from: anAlcixFunction to: aMOJavaClass [

	(translators at: aTranslator ifAbsentPut: [ Set new ]) add:
		(FylgjaTranslatingCouple new
			 provenance: anAlcixFunction;
			 destinationContainer: aMOJavaClass).
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
FylgjaModel >> selectMappingContextFor: aMOJavaClass [

	^ mapspace mapspaceFor: aMOJavaClass anchor
]

{ #category : #accessing }
FylgjaModel >> translators [
	^ translators
]
