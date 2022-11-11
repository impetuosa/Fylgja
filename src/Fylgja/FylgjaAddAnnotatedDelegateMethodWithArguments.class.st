Class {
	#name : #FylgjaAddAnnotatedDelegateMethodWithArguments,
	#superclass : #FylgjaAddDelegateMethodWithArguments,
	#instVars : [
		'annotationProductions'
	],
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #adding }
FylgjaAddAnnotatedDelegateMethodWithArguments >> addAnnotationProduction: aFylgjaAnnotate [

	annotationProductions add: aFylgjaAnnotate
]

{ #category : #adding }
FylgjaAddAnnotatedDelegateMethodWithArguments >> initialize [

	super initialize.
	annotationProductions := OrderedCollection new
]

{ #category : #adding }
FylgjaAddAnnotatedDelegateMethodWithArguments >> privateApplyOn: aMOClassWriter [

	^ aMOClassWriter writeMethod: [ :method | 
		  annotationProductions do: [ :a | a privateApplyOn: method ].
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
