Class {
	#name : #FylgjaAddAssignment,
	#superclass : #FylgjaProduction,
	#instVars : [
		'read',
		'write'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddAssignment >> applyOn: block [

	^ block writeExpressionStatement: [ :stmt | 
		  stmt writeExpression: [ :exp | 
			  exp
				  let: [ :writeExpression | write ]
				  beAssignedWith: [ :readExpression | read ] ] ]
]

{ #category : #accessing }
FylgjaAddAssignment >> read: aMOParameter [ 
	read := aMOParameter
]

{ #category : #accessing }
FylgjaAddAssignment >> write: aMOAttribute [ 
	write := aMOAttribute
]
