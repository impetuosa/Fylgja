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
FylgjaCopyReplaceUnaryOperator >> applyTo: aProvenanceEntity destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ (self
		   writeCopyOf: aProvenanceEntity
		   destinationWriter: aDestinationWriter
		   lookUp: aFylgjaLookUpContext
		   using: aFylgjaDerivativeModel)
		  operator: operator;
		  order: order;
		  yourself
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