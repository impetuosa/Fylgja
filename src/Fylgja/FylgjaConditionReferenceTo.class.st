Class {
	#name : #FylgjaConditionReferenceTo,
	#superclass : #FylgjaCondition,
	#instVars : [
		'elements'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionReferenceTo class >> priority [ 
	^ 9
]

{ #category : #accessing }
FylgjaConditionReferenceTo >> element: anElement [

	elements := { anElement }
]

{ #category : #accessing }
FylgjaConditionReferenceTo >> elements: aCollection [

	elements := aCollection
]

{ #category : #accessing }
FylgjaConditionReferenceTo >> matches: aProvenanceEntity context: aDestinationContext [

	^ aProvenanceEntity isReference and: [ 
		  elements includes: aProvenanceEntity candidate ]
]
