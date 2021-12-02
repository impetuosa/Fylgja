Class {
	#name : #FylgjaConditionEntityIdentity,
	#superclass : #FylgjaCondition,
	#instVars : [
		'entitiy',
		'entity'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionEntityIdentity >> matches: anEntity [

	^ entity == anEntity
]
