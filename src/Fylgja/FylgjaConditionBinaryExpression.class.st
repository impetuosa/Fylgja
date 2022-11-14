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
FylgjaConditionBinaryExpression >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ (aProvenanceEntityRelation to isKindOf: MOBinaryOperation) and: [ 
		  aProvenanceEntityRelation to operator = operator ]
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
