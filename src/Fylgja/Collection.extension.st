Extension { #name : #Collection }

{ #category : #'*Fylgja' }
Collection >> acceptVisitor: aMOTypescriptCodeGenerator [ 
	^ aMOTypescriptCodeGenerator visitCollection: self 
]
