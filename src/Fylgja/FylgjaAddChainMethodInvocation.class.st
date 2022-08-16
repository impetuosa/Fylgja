Class {
	#name : #FylgjaAddChainMethodInvocation,
	#superclass : #FylgjaModification,
	#instVars : [
		'invocations',
		'firstReceiverReference'
	],
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #'instance creation' }
FylgjaAddChainMethodInvocation class >> possibleWritingMessages [

	^ FylgjaAddMethodInvocation possibleWritingMessages
]

{ #category : #adding }
FylgjaAddChainMethodInvocation >> addSelector: aString arguments: aCollection [

	self invocations add: aString -> aCollection
]

{ #category : #accessing }
FylgjaAddChainMethodInvocation >> firstReceiverReference: aMOAttribute [ 
	firstReceiverReference := aMOAttribute
]

{ #category : #accessing }
FylgjaAddChainMethodInvocation >> invocations [

	^ invocations ifNil: [ invocations := OrderedCollection new ]
]

{ #category : #'instance creation' }
FylgjaAddChainMethodInvocation >> privateApplyOn: aWriter [

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
				  privateApplyOn: aWriter ]
]
