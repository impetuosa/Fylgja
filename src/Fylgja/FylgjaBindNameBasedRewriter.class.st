Class {
	#name : #FylgjaBindNameBasedRewriter,
	#superclass : #Object,
	#instVars : [
		'destinationEntity',
		'toBindElement',
		'candidateRelation',
		'destinationWriter',
		'lookUpContext',
		'fylgja'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> adaptInvocationToInvocationToPointToAttributeAccessor [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> adaptInvocationToInvocationToPointToMethod [

	^ toBindElement isStaticBinding
		  ifTrue: [ self adaptInvocationToInvocationToPointToStaticMethod ]
		  ifFalse: [ self adaptInvocationToInvocationToPointToObjectMethod ]
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> adaptInvocationToInvocationToPointToStaticMethod [

	self assert: toBindElement parent isType.
	^ destinationWriter writeUnregisteredExpression: [ :expression | 
		  (expression
			   invokeMethodNamed: toBindElement selector
			   receiver: [ :exp | 
				   (exp typeReferenceNamedForRebinding: toBindElement parent name)
					   referee: toBindElement parent;
					   yourself ]
			   arguments: [ :exp | destinationEntity arguments ])
			  referee: toBindElement;
			  yourself ]
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> adaptInvocationToMethodInvocation [

	self halt.
	self assert: (destinationEntity refersToObjectsLike: toBindElement).
	self assert: destinationEntity name = toBindElement name.
	self assert: (toBindElement parameters collect: #name)
		= (candidateRelation to parameters collect: #name).
	self assert: destinationEntity receiverReference isNotNil.
	candidateRelation write: toBindElement to: destinationEntity.
	^ destinationEntity
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> adaptPrimitiveTypeReferenceToPrimitiveTypeReferenceToPointToClass [

	^ (destinationWriter typeReferenceNamed: toBindElement name)
		  referee: toBindElement;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> adaptPrimitiveTypeReferenceToPrimitiveTypeReferenceToPointToClassType [

	^ self
		  adaptPrimitiveTypeReferenceToPrimitiveTypeReferenceToPointToClass
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> adaptPrimitiveTypeReferenceToPrimitiveTypeReferenceToPointToJavaClass [

	^ self
		  adaptPrimitiveTypeReferenceToPrimitiveTypeReferenceToPointToClass
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> adaptPrimitiveTypeReferenceToPrimitiveTypeReferenceToPointToTypescriptClass [

	^ self
		  adaptPrimitiveTypeReferenceToPrimitiveTypeReferenceToPointToClass
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> adaptVariableReferenceToVariableReferenceToPointToAttribute [

	^ toBindElement isStaticBinding
		  ifTrue: [ 
			  ^ self
				    adaptVariableReferenceToVariableReferenceToPointToStaticAttribute ]
		  ifFalse: [ 
			  self
				  adaptVariableReferenceToVariableReferenceToPointToObjectAttribute ]
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> adaptVariableReferenceToVariableReferenceToPointToLocalVariable [

	^ self trivialAdaptation
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> adaptVariableReferenceToVariableReferenceToPointToStaticAttribute [

	self assert: toBindElement parent isType.
	^ destinationWriter writeUnregisteredExpression: [ :expression | 
		  (expression
			   accessAttribute: toBindElement name
			   receiver: [ :exp | 
				   (exp typeReferenceNamedForRebinding: toBindElement parent name)
					   referee: toBindElement parent;
					   yourself ])
			  referee: toBindElement;
			  yourself ]
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> bind: aDestinationEntity to: aToBindElement semanticallyEquivalentTo: aCandidateRelation destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	destinationEntity := aDestinationEntity.
	toBindElement := aToBindElement.
	candidateRelation := aCandidateRelation.
	destinationWriter := aDestinationWriter.
	lookUpContext := aFylgjaLookUpContext.
	fylgja := aFylgja.
	^ self
		  invokeAdaptationFrom: aCandidateRelation from
		  to: aDestinationEntity
		  forPointingTo: toBindElement

	" 	
(aCandidateRelation to isKindOf: MOFunction ) ifTrue: [ self halt ].
	
	self assert: aCandidateRelation to class = destinationEntity class.
	self assert:
		(currentCandidate isNil or: [ currentCandidate isFylgjaStub ]).
	aCandidateRelation write: destinationEntity to: aDestinationEntity.
	
	^ aDestinationEntity"
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> invokeAdaptationFrom: aReferenceFrom to: aReferenceTo forPointingTo: aDeclaration [

	^ (aReferenceTo refersToObjectsLike: aDeclaration)
		  ifTrue: [ self trivialAdaptation ]
		  ifFalse: [ 
			  self perform: ('adapt{1}To{2}ToPointTo{3}' format: { 
						   (aReferenceFrom className
							    copyFrom: 3
							    to: aReferenceFrom className size).
						   (aReferenceTo className
							    copyFrom: 3
							    to: aReferenceTo className size).
						   (aDeclaration className
							    copyFrom: 3
							    to: aDeclaration className size) }) asSymbol ]
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> trivialAdaptation [

	candidateRelation write: toBindElement to: destinationEntity.
	destinationEntity name: toBindElement name .
	^ destinationEntity
]
