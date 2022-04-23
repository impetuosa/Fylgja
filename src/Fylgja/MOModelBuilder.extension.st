Extension { #name : #MOModelBuilder }

{ #category : #'*Fylgja' }
MOModelBuilder >> fylgjaStubCandidateBuilder [

	^ FylgjaCandidateStubBuilder new
		  parentBuilder: self;
		  yourself
]
