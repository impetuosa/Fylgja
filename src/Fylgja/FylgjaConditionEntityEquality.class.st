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

{ #category : #testing }
FylgjaConditionEntityEquality >> printOn: aStream [

	aStream nextPutAll: 'IsEqualsTo '.
	entity printOn: aStream
]
