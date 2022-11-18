Class {
	#name : #FylgjaTranslateInvocationToMessageSend,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'selector',
		'receiverBlock',
		'argumentCollectionTransform',
		'writer'
	],
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateInvocationToMessageSend >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	[ 
	^ MOModelWriteTypeBasedCopyResolver new
		  resolveWriterFor: aProvenanceEntityRelation
		  writingContext: aDestinationWriter
		  do: [ :elementWriter | 
			  | destinationEntity |
			  destinationEntity := elementWriter writeExpression: [ :stmt | 
				                       stmt
					                       invokeMethodNamed:
					                       (selector ifNil: [ 
						                        aProvenanceEntityRelation to selector ])
					                       receiver: [ 
						                       receiverBlock
							                       cull: stmt
							                       cull: aProvenanceEntityRelation
							                       cull: aDestinationWriter
							                       cull: aFylgjaDerivativeModel ]
					                       arguments: [ :exp | 
						                       argumentCollectionTransform
							                       cull:
								                       ((aProvenanceEntityRelation to 
									                         relationsNamed: #arguments) 
									                        collect: [ :a | 
										                        aFylgjaDerivativeModel
											                        migrate: a
											                        croppingRelationsWith: aBlock
											                        intoDestinationWriter: exp
											                        lookUp: aFylgjaLookUpContext ])
							                       cull: exp ] ].
			  self
				  applyBindTo: destinationEntity
				  withCandidateFrom: aProvenanceEntityRelation
				  croppingRelationsWith: aBlock
				  writer: elementWriter
				  lookup: aFylgjaLookUpContext
				  using: aFylgjaDerivativeModel ] ] ensure: [ 
		selector = nil.
		receiverBlock = nil.
		argumentCollectionTransform = nil.
		writer = nil ]
]

{ #category : #'as yet unclassified' }
FylgjaTranslateInvocationToMessageSend >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isInvocation and: [ 
		  aProvenanceEntityRelation to isFunctionInvocation ]
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
