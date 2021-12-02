Class {
	#name : #FylgjaConditionTypeIs,
	#superclass : #FylgjaCondition,
	#instVars : [
		'type'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionTypeIs >> matches: anAlcixLocalVariable context: aMOMethod [

	^ anAlcixLocalVariable isKindOf: AlcixVariable
]

{ #category : #accessing }
FylgjaConditionTypeIs >> type: aClass [ 
	type := aClass
]
