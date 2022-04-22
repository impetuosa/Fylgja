Class {
	#name : #FylgjaConditionIsPragmaWithSelector,
	#superclass : #FylgjaCondition,
	#instVars : [
		'selector'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionIsPragmaWithSelector >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [
  ^(aProvenanceEntityRelation to isKindOf: MOStatementExpression) 
		and: [ (aProvenanceEntityRelation to expression isKindOf: MOStPragma) 
		and: [ aProvenanceEntityRelation to expression selector = selector ] ]
]

{ #category : #accessing }
FylgjaConditionIsPragmaWithSelector >> selector: aString [ 
	selector := aString
]
