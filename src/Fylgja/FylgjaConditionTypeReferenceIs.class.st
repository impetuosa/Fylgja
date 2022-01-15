Class {
	#name : #FylgjaConditionTypeReferenceIs,
	#superclass : #FylgjaCondition,
	#instVars : [
		'typeNames'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionTypeReferenceIs >> matches: aMOFunction context: aMOClass [

	^ aMOFunction isTypeReference and: [ 
		  typeNames includes: aMOFunction name ]
]

{ #category : #testing }
FylgjaConditionTypeReferenceIs >> typeName: aClass [

	typeNames := { aClass }
]

{ #category : #testing }
FylgjaConditionTypeReferenceIs >> typeNames: anarray [

	typeNames := anarray
]
