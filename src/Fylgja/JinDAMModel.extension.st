Extension { #name : #JinDAMModel }

{ #category : #'*Fylgja' }
JinDAMModel >> primitiveTypeNamed: aString ifAbsent: aFullBlockClosure [ 
	^ aFullBlockClosure value
]
