Class {
	#name : #FylgjaAddDelegateAndTransmitParametersMethod,
	#superclass : #FylgjaAddMethod,
	#instVars : [
		'attributeReference',
		'delegatingMessage'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddDelegateAndTransmitParametersMethod >> applyOn: aMOClassWriter [

	| rp |
	^ aMOClassWriter writeMethod: [ :method | 
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
FylgjaAddDelegateAndTransmitParametersMethod >> attributeReference: aMOVariableReference [ 
	attributeReference := aMOVariableReference
]

{ #category : #accessing }
FylgjaAddDelegateAndTransmitParametersMethod >> selector: aString [

	super selector: aString. 
	delegatingMessage ifNil: [ delegatingMessage := aString ]
]
