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
FylgjaBindNameBasedRewriter >> adaptInvocationToMethodInvocation [

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
		  candidate: toBindElement;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> adaptPrimitiveTypeReferenceToPrimitiveTypeReferenceToPointToClassType [

	^ self
		  adaptPrimitiveTypeReferenceToPrimitiveTypeReferenceToPointToClass
]

{ #category : #'as yet unclassified' }
FylgjaBindNameBasedRewriter >> adaptPrimitiveTypeReferenceToPrimitiveTypeReferenceToPointToTypescriptClass [

	^ self
		  adaptPrimitiveTypeReferenceToPrimitiveTypeReferenceToPointToClass
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
FylgjaBindNameBasedRewriter >> invokeAdaptationFrom: aReferenceFrom to: aReferenceTo [

	^ aReferenceFrom class = aReferenceTo class
		  ifTrue: [ self trivialAdaptation ]
		  ifFalse: [ 
			  self perform: ('adapt{1}To{2}' format: { 
						   (aReferenceFrom className
							    copyFrom: 3
							    to: aReferenceFrom className size).
						   (aReferenceTo className
							    copyFrom: 3
							    to: aReferenceTo className size) }) asSymbol ]
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
