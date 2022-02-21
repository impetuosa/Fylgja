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
FylgjaTranslateInvocationToMessageSend >> applyTo: aProvenanceEntity destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ MOModelWriteTypeBasedCopyResolver new
		  resolveWriterFor: aProvenanceEntity
		  writingContext: aDestinationWriter
		  do: [ :elementWriter | 
			  elementWriter writeExpression: [ :stmt | 
				  stmt
					  invokeMethodNamed:
					  (selector ifNil: [ aProvenanceEntity selector ])
					  receiver: [ 
						  receiverBlock
							  cull: stmt
							  cull: aProvenanceEntity
							  cull: aDestinationWriter
							  cull: aFylgjaDerivativeModel ]
					  arguments: [ :exp | 
						  argumentCollectionTransform
							  cull: (aProvenanceEntity arguments collect: [ :a | 
									   aFylgjaDerivativeModel
										   migrate: a
										   intoDestinationWriter: exp
										   lookUp: aFylgjaLookUpContext ])
							  cull: exp ] ] ]
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
