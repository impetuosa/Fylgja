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
FylgjaConditionModelTypeIsAndContextIs >> matches: aProvenanceEntityRelation context: aDestinationContextRelation [

	^ (contextTypes anySatisfy: [ :t | 
		   aDestinationContextRelation to class = t ]) and: [ 
		  super
			  matches: aProvenanceEntityRelation
			  context: aDestinationContextRelation ]
]
