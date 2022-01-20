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
FylgjaConditionModelTypeIsKindOf >> matches: aProvenanceEntity context: aDestinationContext [

	^ types anySatisfy: [ :t | aProvenanceEntity isKindOf: t ]
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
