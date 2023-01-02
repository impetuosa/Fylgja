Extension { #name : #MOModelWriter }

{ #category : #'*Fylgja' }
MOModelWriter >> fylgjaStubCandidateBuilder [

	^ FylgjaCandidateStubBuilder new
		  parentBuilder: self;
		  yourself
]
