Class {
	#name : #FylgjaTranslateInvocationToMessageSend,
	#superclass : #FylgjaTranslate,
	#instVars : [
		'selector',
		'receiverBlock',
		'argumentCollectionTransform',
		'writer'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateInvocationToMessageSend >> applyTo: aProvenanceEntity context: aDestinationContext using: aFylgjaDerivativeModel [

	| invocation ctx |
	aFylgjaDerivativeModel
		writerFor: aProvenanceEntity
		inContextOf: aDestinationContext
		do: [ :writingEntity :contextWriter | 
			invocation := contextWriter writeExpression: [ :stmt | 
				              stmt
					              invokeMethodNamed:
					              (selector ifNil: [ aProvenanceEntity selector ])
					              receiver: [ 
						              receiverBlock
							              cull: stmt
							              cull: aProvenanceEntity
							              cull: aDestinationContext
							              cull: aFylgjaDerivativeModel ] ] ].
	aFylgjaDerivativeModel
		writerFor: aProvenanceEntity
		inContextOf: invocation
		do: [ :writingEntity :contextWriter | 
			invocation arguments: (argumentCollectionTransform
					 cull: (aProvenanceEntity arguments collect: [ :a | 
							  aFylgjaDerivativeModel migrate: a into: invocation ])
					 cull: contextWriter) ].

	^ invocation
]

{ #category : #'as yet unclassified' }
FylgjaTranslateInvocationToMessageSend >> initialize [

	super initialize.
	argumentCollectionTransform := [ :arguments :argWriter | arguments ]
]

{ #category : #'as yet unclassified' }
FylgjaTranslateInvocationToMessageSend >> receiverBlock: aFullBlockClosure [

	receiverBlock := aFullBlockClosure
]

{ #category : #accessing }
FylgjaTranslateInvocationToMessageSend >> selector: aString [

	selector := aString
]

{ #category : #'as yet unclassified' }
FylgjaTranslateInvocationToMessageSend >> withArgumentCollection: aFullBlockClosure [

	argumentCollectionTransform := aFullBlockClosure
]
