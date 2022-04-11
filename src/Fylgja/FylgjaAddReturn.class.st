Class {
	#name : #FylgjaAddReturn,
	#superclass : #FylgjaProduce,
	#instVars : [
		'variable'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddReturn >> applyOn: aWriter [

	^ aWriter writeReturn: [ :return | 
		  return writeExpression: [ :expression | 
			  (expression variableReferenceNamed: variable name)
				  candidate: variable;
				  yourself ] ]
]

{ #category : #accessing }
FylgjaAddReturn >> variable: aMOAttribute [ 
	variable := aMOAttribute
]
