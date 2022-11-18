Class {
	#name : #FylgjaCopyReplaceUnaryOperator,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'operator',
		'order'
	],
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceUnaryOperator class >> possibleWritingMessages [

	^ { #yourself }
]

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceUnaryOperator >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ (self
		   writeCopyOf: aRelatedProvenanceEntity
		   croppingRelationsWith: aBlock
		   destinationWriter: aDestinationWriter
		   lookUp: aFylgjaLookUpContext
		   using: aFylgjaDerivativeModel)
		  operator: operator;
		  order: order;
		  yourself
]

{ #category : #testing }
FylgjaCopyReplaceUnaryOperator >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isUnaryOperation and: [ 
		  self canWriteOver: aWriter ]
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
