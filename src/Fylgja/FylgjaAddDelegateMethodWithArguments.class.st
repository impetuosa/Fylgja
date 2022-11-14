Class {
	#name : #FylgjaAddDelegateMethodWithArguments,
	#superclass : #FylgjaAddMethod,
	#instVars : [
		'attributeReference',
		'delegatingMethod',
		'delegatingSelector',
		'arguments'
	],
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #accessing }
FylgjaAddDelegateMethodWithArguments >> arguments: aBlock [

	arguments := aBlock
]

{ #category : #accessing }
FylgjaAddDelegateMethodWithArguments >> attributeReference: aMOVariableReference [ 
	attributeReference := aMOVariableReference
]

{ #category : #accessing }
FylgjaAddDelegateMethodWithArguments >> delegatingMethod: aMethod [

	delegatingMethod := aMethod.
	aMethod ifNotNil: [ delegatingSelector := delegatingMethod selector ]
]

{ #category : #accessing }
FylgjaAddDelegateMethodWithArguments >> delegatingSelector: aMethod [

	delegatingSelector := aMethod
]

{ #category : #accessing }
FylgjaAddDelegateMethodWithArguments >> privateApplyOn: aMOClassWriter [

	^ aMOClassWriter writeMethod: [ :method | 
		  method selector: selector.
		  method returnTypeReference: returnTypeReference.
		  method writeBlock: [ :block | 
			  block writeReturn: [ :ret | 
				  ret writeExpression: [ :exp | 
					  (exp
						   invokeMethodNamed: delegatingSelector
						   receiver: [ :e | attributeReference ]
						   arguments: [ :e | arguments value: e ])
						  referee: delegatingMethod;
						  yourself ] ] ] ]
]
