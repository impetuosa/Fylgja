Extension { #name : #MOModelWriter }

{ #category : #'*Fylgja' }
MOModelWriter >> missingTypeReferenceTo: aType withContext: aMOClass [

	^ self builder missingTypeReferenceBuilder
		  type: aType;
		  destinationContext: aMOClass;
		  build
]
