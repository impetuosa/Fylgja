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
FylgjaConditionModelTypeIsAndContextIs >> matches: aProvenanceEntity context: aDestinationContext [

	^ (contextTypes anySatisfy: [ :t | aDestinationContext class = t ]) 
		  and: [ 
		  super matches: aProvenanceEntity context: aDestinationContext ]
]
