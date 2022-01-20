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
FylgjaConditionTypeReferenceIs >> matches: aProvenanceEntity context: aDestinationContext [

	^ aProvenanceEntity isTypeReference and: [ 
		  typeNames includes: aProvenanceEntity name ]
]

{ #category : #testing }
FylgjaConditionTypeReferenceIs >> typeName: aClass [

	typeNames := { aClass }
]

{ #category : #testing }
FylgjaConditionTypeReferenceIs >> typeNames: anarray [

	typeNames := anarray
]
