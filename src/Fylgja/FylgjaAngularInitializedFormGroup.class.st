Class {
	#name : #FylgjaAngularInitializedFormGroup,
	#superclass : #FylgjaAngularModifications,
	#instVars : [
		'name',
		'bindings',
		'initializingMethodSelector'
	],
	#category : #'Fylgja-Rule-Transformations'
}

{ #category : #'instance creation' }
FylgjaAngularInitializedFormGroup class >> possibleWritingMessages [

	^ FylgjaAddAttribute possibleWritingMessages
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
FylgjaAngularInitializedFormGroup >> privateApplyOn: class [

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
						   privateApplyOn: ex ]);
		  privateApplyOn: class
]

{ #category : #writing }
FylgjaAngularInitializedFormGroup >> writeInitializingFormGroup: selector for: bindingsToMap into: class [

	| return |
	^ class writeMethod: [ :method | 
		  method selector: selector.
		  method returnTypeReference: (self formGroupReference: class).
		  method writeBlock: [ :block | 
			  return := block writeStatement: [ :stmt | 
				            stmt
					            variable: '_returning'
					            typeReference: (self formGroupReference: class)
					            initializer: [ :exp | 
						            exp
							            new: (self formGroupReference: class)
							            arguments: [ :ex | 
							            { (ex dictionaryLiteral: Dictionary new) } ] ] ].
			  bindingsToMap keys do: [ :controlName | 
				  block writeStatement: [ :stmt | 
					  stmt
						  invokeMethodNamed: #addControl
						  receiver: [ :exp | 
						  self variableReferenceTo: return using: exp ]
						  arguments: [ :axp | 
							  { 
								  (axp stringLiteral: controlName).
								  (axp new: (self formControlReference: class)) } ] ] ].
			  block writeReturn: [ :ret | 
				  ret writeExpression: [ :ex | 
					  self variableReferenceTo: return using: ex ] ] ] ]
]
