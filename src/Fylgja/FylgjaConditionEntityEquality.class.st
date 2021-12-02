Class {
	#name : #FylgjaConditionEntityEquality,
	#superclass : #FylgjaCondition,
	#instVars : [
		'entitiy'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionEntityEquality >> matches: anEntity [

	^ entitiy = anEntity
]
