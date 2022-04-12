Class {
	#name : #FylgjaConditionTypeReferenceIs,
	#superclass : #FylgjaCondition,
	#instVars : [
		'typeNames'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionTypeReferenceIs class >> priority [
	 ^ 7
]

{ #category : #testing }
FylgjaConditionTypeReferenceIs >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [

	^ aProvenanceEntityRelation to isTypeReference and: [ 
		  typeNames includes: aProvenanceEntityRelation to name ]
]

{ #category : #testing }
FylgjaConditionTypeReferenceIs >> typeName: aClass [

	typeNames := { aClass }
]

{ #category : #testing }
FylgjaConditionTypeReferenceIs >> typeNames: anarray [

	typeNames := anarray
]
