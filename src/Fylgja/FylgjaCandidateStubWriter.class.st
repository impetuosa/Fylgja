Class {
	#name : #FylgjaCandidateStubWriter,
	#superclass : #MOModelProceduralWriter,
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #writing }
FylgjaCandidateStubWriter >> initializeWriteBuilder [

	writeBuilder := builder fylgjaStubCandidateBuilder
]

{ #category : #'as yet unclassified' }
FylgjaCandidateStubWriter >> originalCandidate: aMOPrimitiveType [ 
	writeBuilder originalCandidate: aMOPrimitiveType 
]

{ #category : #writing }
FylgjaCandidateStubWriter >> privateWriteToSurface: anEntity [

]
