Class {
	#name : #FylgjaAddChainMethodInvocation,
	#superclass : #FylgjaProduction,
	#instVars : [
		'invocations',
		'firstReceiverReference'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #adding }
FylgjaAddChainMethodInvocation >> addSelector: aString arguments: aCollection [

	self invocations add: aString -> aCollection
]

{ #category : #'instance creation' }
FylgjaAddChainMethodInvocation >> applyOn: aWriter [

	| selector arguments |
	^ invocations
		  inject: firstReceiverReference 
		  into: [ :receiver :assoc | 
			  selector := assoc key.
			  arguments := assoc value.
			  FylgjaAddMethodInvocation new
				  receiver: receiver;
				  selector: selector;
				  arguments: arguments;
				  applyOn: aWriter ]
]

{ #category : #accessing }
FylgjaAddChainMethodInvocation >> firstReceiverReference: aMOAttribute [ 
	firstReceiverReference := aMOAttribute
]

{ #category : #accessing }
FylgjaAddChainMethodInvocation >> invocations [

	^ invocations ifNil: [ invocations := OrderedCollection new ]
]
