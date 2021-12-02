Class {
	#name : #FylgjaConditionEntityEquality,
	#superclass : #FylgjaCondition,
	#instVars : [
		'entity'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionEntityEquality >> entity: anAlcixLocalVariable [ 
	entity := anAlcixLocalVariable
]

{ #category : #testing }
FylgjaConditionEntityEquality >> matches: anEntity context: context [

	^ entity = anEntity
]
