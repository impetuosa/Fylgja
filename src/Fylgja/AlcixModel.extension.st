Extension { #name : #AlcixModel }

{ #category : #'*Fylgja' }
AlcixModel >> fylgja [

	^ fylgja ifNil: [ 
		  fylgja := FylgjaModel new
			            mooseModel: self;
			            yourself ]
]

{ #category : #'*Fylgja' }
AlcixModel >> primitiveTypeNamed: aString ifAbsent: aFullBlockClosure [ 
	^ aFullBlockClosure value
]
