Class {
	#name : #FylgjaConditionEntityIdentity,
	#superclass : #FylgjaCondition,
	#instVars : [
		'entitiy',
		'entity'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionEntityIdentity >> entity: anAlcixLocalVariable [ 
	entity := anAlcixLocalVariable
]

{ #category : #testing }
FylgjaConditionEntityIdentity >> matches: anEntity context: context [

	^ entity == anEntity
]

{ #category : #accessing }
FylgjaConditionEntityIdentity >> printOn: aStream [

	aStream nextPutAll: 'IsIdenticalTo '.
	entity printOn: aStream
]
