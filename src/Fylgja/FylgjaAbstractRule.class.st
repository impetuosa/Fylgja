Class {
	#name : #FylgjaAbstractRule,
	#superclass : #Object,
	#category : #'Fylgja-Rules'
}

{ #category : #accessing }
FylgjaAbstractRule >> isAdaptingRule [

	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isDelegatingRule [
	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isFylgjaStub [

	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isInvocable [

	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isInvocation [

	^ false
]

{ #category : #accessing }
FylgjaAbstractRule >> isProductionRule [

	^ false
]

{ #category : #accessing }
FylgjaAbstractRule >> isRule [

	^ true
]

{ #category : #testing }
FylgjaAbstractRule >> isStatement [

	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isStatementExpression [

	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isTypeReference [
^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isVariable [

	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> priority [

	^ self subclassResponsibility
]
