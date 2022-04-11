Class {
	#name : #FylgjaAddAssignment,
	#superclass : #FylgjaProduce,
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
				  let: [ :writeExpression | 
					  (writeExpression variableReferenceNamed: write name)
						  candidate: write;
						  yourself ]
				  beAssignedWith: [ :readExpression | 
					  (readExpression variableReferenceNamed: read name)
						  candidate: read;
						  yourself ] ] ]
]

{ #category : #accessing }
FylgjaAddAssignment >> read: aMOParameter [ 
	read := aMOParameter
]

{ #category : #accessing }
FylgjaAddAssignment >> write: aMOAttribute [ 
	write := aMOAttribute
]
