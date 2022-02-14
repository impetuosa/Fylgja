Class {
	#name : #FylgjaConditionUnaryOperator,
	#superclass : #FylgjaCondition,
	#instVars : [
		'operator',
		'order'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionUnaryOperator >> matches: aProvenanceEntity context: aDestinationContext [

	^ (aProvenanceEntity isKindOf: MOUnaryOperation) and: [ 
		  aProvenanceEntity operator = operator and: [ 
			  order = aProvenanceEntity order ] ]
]

{ #category : #testing }
FylgjaConditionUnaryOperator >> operator: aString [ 
	operator := aString
]

{ #category : #testing }
FylgjaConditionUnaryOperator >> setAsPostfix [
	order := #postfix
]

{ #category : #testing }
FylgjaConditionUnaryOperator >> setAsPrefix [ 
	order := #prefix
]
