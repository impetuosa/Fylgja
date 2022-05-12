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
FylgjaConditionReferenceNamed >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ aProvenanceEntityRelation to isReference and: [ 
		  names includes: aProvenanceEntityRelation to name ]
]

{ #category : #testing }
FylgjaConditionReferenceNamed >> name: aClass [

	names := { aClass }
]

{ #category : #testing }
FylgjaConditionReferenceNamed >> names: anarray [

	names := anarray
]
