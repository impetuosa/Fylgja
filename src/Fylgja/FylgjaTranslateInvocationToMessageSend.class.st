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
FylgjaTranslateInvocationToMessageSend >> applyTo: aRelatedProvenanceEntity destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ MOModelWriteTypeBasedCopyResolver new
		  resolveWriterFor: aRelatedProvenanceEntity
		  writingContext: aDestinationWriter
		  do: [ :elementWriter | 
			  elementWriter writeExpression: [ :stmt | 
				  stmt
					  invokeMethodNamed:
					  (selector ifNil: [ aRelatedProvenanceEntity selector ])
					  receiver: [ 
						  receiverBlock
							  cull: stmt
							  cull: aRelatedProvenanceEntity
							  cull: aDestinationWriter
							  cull: aFylgjaDerivativeModel ]
					  arguments: [ :exp | 
						  argumentCollectionTransform
							  cull: (aRelatedProvenanceEntity arguments collect: [ :a | 
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
