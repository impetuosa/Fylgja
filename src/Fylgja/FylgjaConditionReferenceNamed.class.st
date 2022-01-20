Class {
	#name : #FylgjaConditionReferenceNamed,
	#superclass : #FylgjaCondition,
	#instVars : [
		'names'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionReferenceNamed class >> priority [
	 ^ 7
]

{ #category : #testing }
FylgjaConditionReferenceNamed >> matches: aProvenanceEntity context: aDestinationContext [

	^ aProvenanceEntity isReference and: [ 
		  names includes: aProvenanceEntity name ]
]

{ #category : #testing }
FylgjaConditionReferenceNamed >> name: aClass [

	names := { aClass }
]

{ #category : #testing }
FylgjaConditionReferenceNamed >> names: anarray [

	names := anarray
]
