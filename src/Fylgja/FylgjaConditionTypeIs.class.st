Class {
	#name : #FylgjaConditionTypeIs,
	#superclass : #FylgjaCondition,
	#instVars : [
		'types'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionTypeIs >> matches: anAlcixLocalVariable context: aMOMethod [

	^ types anySatisfy: [ :t | anAlcixLocalVariable isKindOf: t ]
]

{ #category : #testing }
FylgjaConditionTypeIs >> printOn: aStream [

	aStream nextPutAll:
		('TypeIsAnyOf:({1})' format: { ('|' join: (types collect: #name)) })
]

{ #category : #accessing }
FylgjaConditionTypeIs >> type: aClass [

	types := { aClass }
]

{ #category : #accessing }
FylgjaConditionTypeIs >> types: aCollection [

	types := aCollection
]
