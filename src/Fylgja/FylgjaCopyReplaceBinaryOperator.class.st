Class {
	#name : #FylgjaCopyReplaceBinaryOperator,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'operator'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceBinaryOperator >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ (self
		   writeCopyOf: aProvenanceEntityRelation
			croppingRelationsWith: aBlock 
		   destinationWriter: aDestinationWriter
		   lookUp: aFylgjaLookUpContext
		   using: aFylgjaDerivativeModel)
		  operator: operator;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceBinaryOperator >> isWrittenInContext: aProvenanceEntity context: aDestinationContext [
	^ (aProvenanceEntity isTypeReference ) not
]

{ #category : #accessing }
FylgjaCopyReplaceBinaryOperator >> operator: aString [ 
	operator := aString
]

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceBinaryOperator >> printOn: aStream [

	aStream
		nextPutAll: '{L} ';
		nextPutAll: operator;
		nextPutAll: '{R}'
]
