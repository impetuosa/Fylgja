Class {
	#name : #FylgjaAddMethodInvocation,
	#superclass : #FylgjaModification,
	#instVars : [
		'receiver',
		'selector',
		'arguments',
		'method'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddMethodInvocation class >> possibleWritingMessages [

	^ { #writeStatement:. #writeBlock:. #writenExpression:.
	  #invokeMethodNamed:receiver:arguments: }
]

{ #category : #'instance creation' }
FylgjaAddMethodInvocation >> arguments [

	^ arguments ifNil: [ {  } ]
]

{ #category : #accessing }
FylgjaAddMethodInvocation >> arguments: aCollection [ 
	arguments := aCollection
]

{ #category : #accessing }
FylgjaAddMethodInvocation >> method: aMethod [
	method := aMethod.
	self selector: aMethod selector
]

{ #category : #'instance creation' }
FylgjaAddMethodInvocation >> privateApplyOn: aWriter [

	^ aWriter acceptWritingVisitor: self
]

{ #category : #accessing }
FylgjaAddMethodInvocation >> receiver: aMOAttribute [ 
	receiver := aMOAttribute
]

{ #category : #accessing }
FylgjaAddMethodInvocation >> selector: aString [ 
	selector := aString
]

{ #category : #visiting }
FylgjaAddMethodInvocation >> visitBlockWriter: aMOBlockWriter [

	^ aMOBlockWriter writeStatement: [ :stmt | 
		  stmt acceptWritingVisitor: self ]
]

{ #category : #visiting }
FylgjaAddMethodInvocation >> visitClosureWriter: aMOBlockClosureWriter [

	^ aMOBlockClosureWriter writeBlock: [ :block | 
		  block acceptWritingVisitor: self ]
]

{ #category : #accessing }
FylgjaAddMethodInvocation >> visitExpressionWriter: aWriter [

	^ (aWriter
		   invokeMethodNamed: selector
		   receiver: [ :e | receiver ]
		   arguments: [ :e | self arguments ])
		  candidate: method;
		  yourself
]

{ #category : #accessing }
FylgjaAddMethodInvocation >> visitStatementWriter: aWriter [

	^ aWriter writenExpression:
		  (aWriter writeExpression: [ :exp | exp acceptWritingVisitor: self ])
]
