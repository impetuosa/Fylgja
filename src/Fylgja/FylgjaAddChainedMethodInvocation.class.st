Class {
	#name : #FylgjaAddChainedMethodInvocation,
	#superclass : #FylgjaAddMethodInvocation,
	#instVars : [
		'chained'
	],
	#category : #'Fylgja-Rule-Transformations'
}

{ #category : #accessing }
FylgjaAddChainedMethodInvocation >> chained: aFylgjaAddMethodInvocation [ 
	chained := aFylgjaAddMethodInvocation
]

{ #category : #visiting }
FylgjaAddChainedMethodInvocation >> visitExpressionWriter: aWriter [

	^ aWriter writeExpression: [ :exp | 
		  | nextReceiver |
		  nextReceiver := super visitExpressionWriter: exp.
		  chained arguments isBlock ifTrue: [ 
			  chained arguments: (chained arguments value: aWriter) ].
		  chained
			  receiver: nextReceiver;
			  applyOn: aWriter ]
]
