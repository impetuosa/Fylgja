Class {
	#name : #FylgjaReadMapper,
	#superclass : #Object,
	#instVars : [
		'fylgja',
		'model',
		'destinationContext',
		'errors'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #'as yet unclassified' }
FylgjaReadMapper >> destinationContext: aMOClass [

	destinationContext := aMOClass
]

{ #category : #'as yet unclassified' }
FylgjaReadMapper >> destinationModel: aMOModel [ 
	model := aMOModel 
]

{ #category : #'as yet unclassified' }
FylgjaReadMapper >> errors [
	^ errors ifNil: [ errors := OrderedCollection new ]
]

{ #category : #accessing }
FylgjaReadMapper >> fylgja: aFylgjaModel [ 
	fylgja := aFylgjaModel
]

{ #category : #'as yet unclassified' }
FylgjaReadMapper >> getInvocationFor: anAlcixFunction arguments: aCollection from: anAlcixInvocation [

	| errorRef |
	^ (fylgja
		   getOrProduce: anAlcixFunction
		   for: destinationContext
		   ifNotProducerAvailable: [ 
			   errorRef := model instantiate: FylgjaMissingInvocableInvocation.
			   errorRef
				   referenceTo: anAlcixFunction;
				   relatedInvocation: anAlcixInvocation;
				   destinationContext: destinationContext.
			   self errors add: errorRef.
			   errorRef ])
		  arguments: aCollection;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaReadMapper >> getInvocationFor: anAlcixAttributeAccessor from: anAlcixInvocation [

	| errorRef |
	^ fylgja
		  getOrProduce: anAlcixAttributeAccessor
		  for: destinationContext
		  ifNotProducerAvailable: [ 
			  errorRef := model instantiate: FylgjaMissingInvocableInvocation .
			  errorRef
				  referenceTo: anAlcixAttributeAccessor;
				  relatedInvocation: anAlcixInvocation;
				  destinationContext: destinationContext.
			  self errors add: errorRef.
			  errorRef ]
]

{ #category : #'as yet unclassified' }
FylgjaReadMapper >> getInvocationForNonResolvedCall: aString arguments: aCollection invocationContext: invocationContext [

	| errorRef |
	errorRef := model instantiate: FylgjaMissingInvocableInvocation.

	errorRef
		referenceTo: aString;
		arguments: aCollection;
		relatedInvocation: invocationContext;
		destinationContext: destinationContext.
	self errors add: errorRef.
	^ errorRef
]

{ #category : #'as yet unclassified' }
FylgjaReadMapper >> getInvocationForOperator: aString [

	| errorRef |
	^ fylgja
		  getOrProduce: aString asSymbol
		  for: destinationContext
		  ifNotProducerAvailable: [ 
			  errorRef := model instantiate: FylgjaMissingOperator.
			  errorRef
				  operator: aString;
				  destinationContext: destinationContext.
			  self errors add: errorRef.
			  errorRef ]
]

{ #category : #'as yet unclassified' }
FylgjaReadMapper >> getReference: anAlcixPrimitiveType from: anAlcixParameter [

	| errorRef |
	^ fylgja
		  getOrProduce: anAlcixPrimitiveType
		  for: destinationContext
		  ifNotProducerAvailable: [ 
			  errorRef := model instantiate: FylgjaMissingType.
			  errorRef
				  referenceTo: anAlcixPrimitiveType;
				  relatedTypedEntity: anAlcixParameter;
				  destinationContext: destinationContext.
			  self errors add: errorRef.
			  errorRef ]
]

{ #category : #'as yet unclassified' }
FylgjaReadMapper >> getVariableReference: anAlcixEnumValue from: anAlcixAccess [

	| errorRef |
	^ fylgja
		  getOrProduce: anAlcixEnumValue
		  for: destinationContext
		  ifNotProducerAvailable: [ 
			  errorRef := model instantiate: FylgjaMissingVariable.
			  errorRef
				  referenceTo: anAlcixEnumValue;
				  relatedContext: anAlcixAccess;
				  destinationContext: destinationContext.
			  self errors add: errorRef.
			  errorRef ]
]

{ #category : #'as yet unclassified' }
FylgjaReadMapper >> hackieMissingVariableReference: aString for: aVBArgumentNode [

	| errorRef |
	errorRef := model instantiate: FylgjaMissingVariable.
	errorRef
		referenceTo: aString;
		relatedContext: aVBArgumentNode;
		destinationContext: destinationContext.
	self errors add: errorRef.
	^ errorRef
]
