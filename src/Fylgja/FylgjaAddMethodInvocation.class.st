Class {
	#name : #FylgjaAddMethodInvocation,
	#superclass : #FylgjaProduction,
	#instVars : [
		'receiver',
		'selector',
		'arguments'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddMethodInvocation >> applyOn: aWriter [

	^ aWriter
		  invokeMethodNamed: selector
		  receiver: [ :e | receiver ]
		  arguments: [ :e | arguments ]
]

{ #category : #accessing }
FylgjaAddMethodInvocation >> arguments: aCollection [ 
	arguments := aCollection
]

{ #category : #accessing }
FylgjaAddMethodInvocation >> receiver: aMOAttribute [ 
	receiver := aMOAttribute
]

{ #category : #accessing }
FylgjaAddMethodInvocation >> selector: aString [ 
	selector := aString
]
