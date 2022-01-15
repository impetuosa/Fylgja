Class {
	#name : #FylgjaConditionModelTypeIs,
	#superclass : #FylgjaCondition,
	#instVars : [
		'types'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionModelTypeIs >> matches: anAlcixLocalVariable context: aMOMethod [

	^ types anySatisfy: [ :t | anAlcixLocalVariable isKindOf: t ]
]

{ #category : #testing }
FylgjaConditionModelTypeIs >> printOn: aStream [

	aStream nextPutAll:
		('ModelTypeIsAnyOf:({1})' format: { ('|' join: (types collect: #name)) })
]

{ #category : #accessing }
FylgjaConditionModelTypeIs >> type: aClass [

	types := { aClass }
]

{ #category : #accessing }
FylgjaConditionModelTypeIs >> types: aCollection [

	types := aCollection
]
