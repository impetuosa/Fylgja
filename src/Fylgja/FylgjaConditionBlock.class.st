Class {
	#name : #FylgjaConditionBlock,
	#superclass : #FylgjaCondition,
	#instVars : [
		'block'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionBlock class >> priority [

	^ 1
]

{ #category : #testing }
FylgjaConditionBlock >> matches: aProvenanceEntity context: aDestinationContext [


	^ block cull: aProvenanceEntity cull: aDestinationContext
]

{ #category : #testing }
FylgjaConditionBlock >> printOn: aStream [ 
	aStream nextPutAll:  'BlockEvaluatesTrue'
]
