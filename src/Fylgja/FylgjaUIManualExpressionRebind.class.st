Class {
	#name : #FylgjaUIManualExpressionRebind,
	#superclass : #FylgjaUITransformCommand,
	#category : #'Fylgja-UI-Command-Transform'
}

{ #category : #'accessing - defaults' }
FylgjaUIManualExpressionRebind class >> defaultName [

	^ 'Manual Expression Bind'
]

{ #category : #testing }
FylgjaUIManualExpressionRebind >> canBeExecuted [

	^ self context selectedItems size = 1 and: [ 
		  self context selectedItems allSatisfy: [ :i | 
			  i isInvocation or: [ 
				  i isStatementExpression and: [ i expression isInvocation ] ] ] ]
]

{ #category : #executing }
FylgjaUIManualExpressionRebind >> execute [
	self shouldBeImplemented.
]
