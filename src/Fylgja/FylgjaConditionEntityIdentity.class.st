Class {
	#name : #FylgjaConditionEntityIdentity,
	#superclass : #FylgjaCondition,
	#instVars : [
		'entitiy',
		'entity'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionEntityIdentity class >> priority [

	^ 10
]

{ #category : #accessing }
FylgjaConditionEntityIdentity >> entity: anAlcixLocalVariable [ 
	entity := anAlcixLocalVariable
]

{ #category : #testing }
FylgjaConditionEntityIdentity >> matches: aProvenanceEntity context: aDestinationContext [
	^ entity == aProvenanceEntity
]

{ #category : #accessing }
FylgjaConditionEntityIdentity >> printOn: aStream [

	aStream nextPutAll: 'IsIdenticalTo '.
	entity printOn: aStream
]
