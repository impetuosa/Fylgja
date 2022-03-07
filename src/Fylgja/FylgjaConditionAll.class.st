Class {
	#name : #FylgjaConditionAll,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionAll >> matches: aProvenanceEntityRelation context: aDestinationContextRelation [


	^ true
]

{ #category : #testing }
FylgjaConditionAll >> printOn: aStream [ 
	aStream nextPutAll: 'AllwaysTrue'
]
