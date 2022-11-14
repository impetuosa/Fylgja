Extension { #name : #XMLNode }

{ #category : #'*Fylgja' }
XMLNode >> acceptVisitor: aMoxingHtmlAstComposer [

	^ self acceptNodeVisitor: aMoxingHtmlAstComposer
]
