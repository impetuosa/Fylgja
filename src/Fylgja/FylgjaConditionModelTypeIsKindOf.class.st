Class {
	#name : #FylgjaConditionModelTypeIsKindOf,
	#superclass : #FylgjaCondition,
	#instVars : [
		'types'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionModelTypeIsKindOf class >> priority [
	 ^ 6
]

{ #category : #testing }
FylgjaConditionModelTypeIsKindOf >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [

	^ types anySatisfy: [ :t | aProvenanceEntityRelation to isKindOf: t ]
]

{ #category : #testing }
FylgjaConditionModelTypeIsKindOf >> printOn: aStream [

	aStream nextPutAll:
		('ModelTypeIsAnyOf:({1})' format: { ('|' join: (types collect: #name)) })
]

{ #category : #accessing }
FylgjaConditionModelTypeIsKindOf >> type: aClass [

	types := { aClass }
]

{ #category : #accessing }
FylgjaConditionModelTypeIsKindOf >> types: aCollection [

	types := aCollection
]
