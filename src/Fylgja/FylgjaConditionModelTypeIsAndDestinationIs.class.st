Class {
	#name : #FylgjaConditionModelTypeIsAndDestinationIs,
	#superclass : #FylgjaConditionModelTypeIs,
	#instVars : [
		'destinations'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionModelTypeIsAndDestinationIs >> destination: aClass [

	destinations := { aClass }
]

{ #category : #testing }
FylgjaConditionModelTypeIsAndDestinationIs >> destinations: aCollection [

	destinations := aCollection
]

{ #category : #testing }
FylgjaConditionModelTypeIsAndDestinationIs >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [

	^ (destinations anySatisfy: [ :t | 
		   aDestinationContextRelation to class = t ]) and: [ 
		  super
			  matches: aProvenanceEntityRelation
			  context: aDestinationContextRelation
			  forWriting: aType ]
]
