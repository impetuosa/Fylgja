Class {
	#name : #FylgjaConditionBlock,
	#superclass : #FylgjaCondition,
	#instVars : [
		'block'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionBlock >> matches: anEntity context: aContext [

	^ block cull: anEntity cull: aContext
]

{ #category : #testing }
FylgjaConditionBlock >> printOn: aStream [ 
	aStream nextPutAll:  'BlockEvaluatesTrue'
]
