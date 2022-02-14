Class {
	#name : #FylgjaCopyReplaceUnaryOperator,
	#superclass : #FylgjaTranslate,
	#instVars : [
		'operator',
		'order'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceUnaryOperator >> applyTo: aProvenanceEntity context: aDestinationContext using: aFylgjaDerivativeModel [

	^ aFylgjaDerivativeModel
		  writerFor: aProvenanceEntity
		  inContextOf: aDestinationContext
		  do: [ :writingEntity :contextWriter | 
			  (self
				   writeCopyOf: writingEntity
				   withContext: aDestinationContext
				   inWriter: contextWriter
				   using: aFylgjaDerivativeModel)
				  operator: operator;
				  order: order;
				  yourself ]
]

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceUnaryOperator >> isWrittenInContext: aProvenanceEntity context: aDestinationContext [
	^ (aProvenanceEntity isTypeReference ) not
]

{ #category : #accessing }
FylgjaCopyReplaceUnaryOperator >> operator: aString [ 
	operator := aString
]

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceUnaryOperator >> printOn: aStream [

	aStream
		nextPutAll: '{L} ';
		nextPutAll: operator;
		nextPutAll: '{R}'
]

{ #category : #accessing }
FylgjaCopyReplaceUnaryOperator >> setAsPostfix [
	order := #postfix
]

{ #category : #accessing }
FylgjaCopyReplaceUnaryOperator >> setAsPrefix [ 
	order := #prefix
]
