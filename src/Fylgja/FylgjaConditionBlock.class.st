Class {
	#name : #FylgjaConditionBlock,
	#superclass : #FylgjaCondition,
	#instVars : [
		'block'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionBlock >> matches: anEntity [
 	^ block value: anEntity 
]
