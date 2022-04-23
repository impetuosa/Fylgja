Class {
	#name : #FylgjaConditionModelTypeIsAndContextIs,
	#superclass : #FylgjaConditionModelTypeIs,
	#instVars : [
		'contextTypes'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionModelTypeIsAndContextIs >> contextType: aClass [

	contextTypes  := { aClass }
]

{ #category : #testing }
FylgjaConditionModelTypeIsAndContextIs >> contextTypes: aCollection [

	contextTypes := aCollection
]

{ #category : #testing }
FylgjaConditionModelTypeIsAndContextIs >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [

	^ (contextTypes anySatisfy: [ :t | aType = t ]) and: [ 
		  super
			  matches: aProvenanceEntityRelation
			  context: aDestinationContextRelation
			  forWriting: aType ]
]
