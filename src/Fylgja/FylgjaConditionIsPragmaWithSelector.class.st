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
  ^(aProvenanceEntityRelation to isKindOf: MOStPragma) and: [ aProvenanceEntityRelation to selector = selector ]
]

{ #category : #accessing }
FylgjaConditionIsPragmaWithSelector >> selector: aString [ 
	selector := aString
]
