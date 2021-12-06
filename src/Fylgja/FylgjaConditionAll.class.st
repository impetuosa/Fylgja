Class {
	#name : #FylgjaConditionAll,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionAll >> matches: anAlcixLocalVariable context: aMOMethod [

	^ true
]

{ #category : #testing }
FylgjaConditionAll >> printOn: aStream [ 
	aStream nextPutAll: 'AllwaysTrue'
]
