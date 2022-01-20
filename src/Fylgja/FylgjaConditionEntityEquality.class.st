Class {
	#name : #FylgjaConditionEntityEquality,
	#superclass : #FylgjaCondition,
	#instVars : [
		'entity'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionEntityEquality class >> priority [
	^ 8
]

{ #category : #accessing }
FylgjaConditionEntityEquality >> entity: anAlcixLocalVariable [ 
	entity := anAlcixLocalVariable
]

{ #category : #testing }
FylgjaConditionEntityEquality >> matches: aProvenanceEntity context: aDestinationContext [

	^ entity = aProvenanceEntity
]

{ #category : #testing }
FylgjaConditionEntityEquality >> printOn: aStream [

	aStream nextPutAll: 'IsEqualsTo '.
	entity printOn: aStream
]
