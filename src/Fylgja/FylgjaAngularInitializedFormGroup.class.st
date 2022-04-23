Class {
	#name : #FylgjaAngularInitializedFormGroup,
	#superclass : #FylgjaAngularModifications,
	#instVars : [
		'name',
		'bindings',
		'initializingMethodSelector'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #writing }
FylgjaAngularInitializedFormGroup >> applyOn: class [

	| method |
	method := self
		          writeInitializingFormGroup:
		          self initializingMethodSelector
		          for: bindings
		          into: class.
	^ FylgjaAddAttribute new
		  name: name;
		  typeReference: (self formGroupReference: class);
		  initializer: (class writeUnregisteredExpression: [ :ex | 
					   FylgjaAddMethodInvocation new
						   method: method;
						   receiver: ex referenceToSelf;
						   applyOn: ex ]);
		  applyOn: class
]

{ #category : #accessing }
FylgjaAngularInitializedFormGroup >> bindings: aCollection [ 
	bindings := aCollection
]

{ #category : #writing }
FylgjaAngularInitializedFormGroup >> initializingMethodSelector [

	^ initializingMethodSelector ifNil: [ 
		  initializingMethodSelector := #init , name capitalized ]
]

{ #category : #accessing }
FylgjaAngularInitializedFormGroup >> name: aString [ 
	name := aString
]

{ #category : #writing }
FylgjaAngularInitializedFormGroup >> writeInitializingFormGroup: selector for: bindingsToMap into: class [

	| return |
	self assert: bindingsToMap isEmpty.
	^ class writeMethod: [ :method | 
		  method selector: selector.
		  method returnTypeReference: (self formGroupReference: class).
		  method writeBlock: [ :block | 
			  return := block writeStatement: [ :stmt | 
				            stmt
					            variable: '_returning'
					            typeReference: (self formGroupReference: class)
					            initializer: [ :exp | 
					            exp new: (self formGroupReference: class) ] ].
			  block writeReturn: [ :ret | 
				  ret writeExpression: [ :ex | 
					  self variableReferenceTo: return using: ex ] ] ] ]
]
