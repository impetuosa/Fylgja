Class {
	#name : #FylgjaCopyReplaceBinaryOperator,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'operator'
	],
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceBinaryOperator class >> possibleWritingMessages [

	^ { #yourself }
]

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

{ #category : #testing }
FylgjaCopyReplaceBinaryOperator >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isBinaryOperation and: [ 
		  self canWriteOver: aWriter ]
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
