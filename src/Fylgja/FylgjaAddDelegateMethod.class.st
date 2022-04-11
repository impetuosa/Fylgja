Class {
	#name : #FylgjaAddDelegateMethod,
	#superclass : #FylgjaProduction,
	#instVars : [
		'attributeReference',
		'returnTypeReference',
		'selector',
		'delegatingMessage',
		'parameters'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddDelegateMethod >> applyOn: aMOClassWriter [

	| rp |
	aMOClassWriter writeMethod: [ :method | 
		method selector: selector.
		method returnTypeReference: returnTypeReference.
		rp := self parameters collect: [ :kv | 
			      method writeParameter: [ :param | 
				      param
					      name: kv key;
					      typeReference: kv value ] ].

		method writeBlock: [ :block | 
			block writeReturn: [ :ret | 
				ret writeExpression: [ :exp | 
					exp
						invokeMethodNamed: delegatingMessage
						receiver: [ :e | attributeReference ]
						arguments: [ :e | 
						rp collect: [ :pa | self variableReferenceTo: pa using: e ] ] ] ] ] ]
]

{ #category : #accessing }
FylgjaAddDelegateMethod >> attributeReference: aMOVariableReference [ 
	attributeReference := aMOVariableReference
]

{ #category : #accessing }
FylgjaAddDelegateMethod >> parameters [

	^ parameters ifNil: [ {  } ]
]

{ #category : #generated }
FylgjaAddDelegateMethod >> parameters: aCollection [

	parameters := aCollection
]

{ #category : #accessing }
FylgjaAddDelegateMethod >> returnTypeReference: aMOTypeReference [ 
	returnTypeReference := aMOTypeReference
]

{ #category : #accessing }
FylgjaAddDelegateMethod >> selector: aString [

	selector := aString.
	delegatingMessage ifNil: [ delegatingMessage := selector ]
]
