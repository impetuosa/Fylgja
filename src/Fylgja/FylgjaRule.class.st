Class {
	#name : #FylgjaRule,
	#superclass : #Object,
	#instVars : [
		'condition'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #accessing }
FylgjaRule >> condition: aFylgjaConditionAll [ 
	condition := aFylgjaConditionAll
]

{ #category : #testing }
FylgjaRule >> matches: anAlcixLocalVariable context: aMOMethod [

	^ condition matches: anAlcixLocalVariable context: aMOMethod
]
