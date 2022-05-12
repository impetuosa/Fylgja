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
FylgjaConditionUnaryOperator >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ (aProvenanceEntityRelation to isKindOf: MOUnaryOperation) and: [ 
		  aProvenanceEntityRelation to operator = operator and: [ 
			  order = aProvenanceEntityRelation to order ] ]
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
