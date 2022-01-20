Class {
	#name : #FylgjaCopyReplaceOperator,
	#superclass : #FylgjaTranslate,
	#instVars : [
		'operator'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceOperator >> applyTo: aProvenanceEntity context: aDestinationContext using: aFylgjaDerivativeModel [

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
				  yourself ]
]

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceOperator >> isWrittenInContext: aProvenanceEntity context: aDestinationContext [
	^ (aProvenanceEntity isTypeReference ) not
]

{ #category : #accessing }
FylgjaCopyReplaceOperator >> operator: aString [ 
	operator := aString
]

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceOperator >> printOn: aStream [

	aStream
		nextPutAll: '{L} ';
		nextPutAll: operator;
		nextPutAll: '{R}'
]
