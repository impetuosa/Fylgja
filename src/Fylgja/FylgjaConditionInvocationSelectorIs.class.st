Class {
	#name : #FylgjaConditionInvocationSelectorIs,
	#superclass : #FylgjaCondition,
	#instVars : [
		'selector'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaConditionInvocationSelectorIs >> matches: aMOFunction context: aMOClass [

	^ aMOFunction isInvocation and: [ aMOFunction selector = selector ]
]

{ #category : #accessing }
FylgjaConditionInvocationSelectorIs >> selector: aString [ 
	selector := aString
]
