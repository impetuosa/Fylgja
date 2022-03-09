Class {
	#name : #FylgjaConditionModelTypeIs,
	#superclass : #FylgjaCondition,
	#instVars : [
		'types'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionModelTypeIs class >> priority [
	 ^ 7 
]

{ #category : #testing }
FylgjaConditionModelTypeIs >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [

	^ types anySatisfy: [ :t | aProvenanceEntityRelation to class = t ]
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
