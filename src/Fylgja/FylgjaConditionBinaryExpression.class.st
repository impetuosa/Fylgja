Class {
	#name : #FylgjaConditionBinaryExpression,
	#superclass : #FylgjaCondition,
	#instVars : [
		'operator'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionBinaryExpression class >> priority [

	^ 8
]

{ #category : #testing }
FylgjaConditionBinaryExpression >> matches: aProvenanceEntity context: aDestinationContext [

	^ (aProvenanceEntity isKindOf: MOBinaryOperation) and: [ 
		  aProvenanceEntity operator = operator ]
]

{ #category : #accessing }
FylgjaConditionBinaryExpression >> operator: aString [ 
	operator := aString
]

{ #category : #accessing }
FylgjaConditionBinaryExpression >> printOn: aStream [

	aStream
		nextPutAll: 'Binary {L} ';
		nextPutAll: operator;
		nextPutAll: ' {R} '
]
