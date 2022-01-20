Class {
	#name : #FylgjaConditionAll,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionAll >> matches: aProvenanceEntity context: aDestinationContext [


	^ true
]

{ #category : #testing }
FylgjaConditionAll >> printOn: aStream [ 
	aStream nextPutAll: 'AllwaysTrue'
]
