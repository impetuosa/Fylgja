Extension { #name : #MOModelProceduralWriter }

{ #category : #'*Fylgja' }
MOModelProceduralWriter >> writeFylgjaCandidateStub: aFullBlockClosure [

	^ self
		  write: aFullBlockClosure
		  inSubWriter: FylgjaCandidateStubWriter
]
