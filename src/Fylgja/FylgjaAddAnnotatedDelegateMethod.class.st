Class {
	#name : #FylgjaAddAnnotatedDelegateMethod,
	#superclass : #FylgjaAddDelegateMethod,
	#instVars : [
		'annotationProductions'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #initialization }
FylgjaAddAnnotatedDelegateMethod >> addAnnotationProduction: aFylgjaAnnotate [

	annotationProductions add: aFylgjaAnnotate
]

{ #category : #initialization }
FylgjaAddAnnotatedDelegateMethod >> applyOn: aMOClassWriter [

	| rp |
	aMOClassWriter writeMethod: [ :method | 
		annotationProductions do: [ :a | a applyOn: method ].
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

{ #category : #initialization }
FylgjaAddAnnotatedDelegateMethod >> initialize [

	super initialize.
	annotationProductions := OrderedCollection new
]
