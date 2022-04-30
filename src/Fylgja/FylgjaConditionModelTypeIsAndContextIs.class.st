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

	aType ifNil: [ ^ false ].
	^ (contextTypes anySatisfy: [ :t | 
		   aType = t or: [ aType inheritsFrom: t ] ]) and: [ 
		  super
			  matches: aProvenanceEntityRelation
			  context: aDestinationContextRelation
			  forWriting: aType ]
]
