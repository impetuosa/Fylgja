Extension { #name : #MOModelBuilder }

{ #category : #'*Fylgja' }
MOModelBuilder >> missingTypeReferenceBuilder [

	^ FylgjaMissingTypeReferenceBuilder new
		  parentBuilder: self;
		  yourself
]
