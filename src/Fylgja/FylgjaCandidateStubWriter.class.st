Class {
	#name : #FylgjaCandidateStubWriter,
	#superclass : #MOModelProceduralWriter,
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #visiting }
FylgjaCandidateStubWriter >> acceptWritingVisitor: aVisitor [
	^ aVisitor visitStubWriter: self 


]

{ #category : #accessing }
FylgjaCandidateStubWriter >> candidate: aMOPrimitiveType [ 
	writeBuilder candidate: aMOPrimitiveType 
]

{ #category : #writing }
FylgjaCandidateStubWriter >> initializeWriteBuilder [

	writeBuilder := builder fylgjaStubCandidateBuilder
]

{ #category : #accessing }
FylgjaCandidateStubWriter >> parent: aMOPrimitiveTypeReference [ 
	writeBuilder parent: aMOPrimitiveTypeReference 
]

{ #category : #writing }
FylgjaCandidateStubWriter >> privateWriteToSurface: anEntity [

]

{ #category : #'as yet unclassified' }
FylgjaCandidateStubWriter >> provenance: aMOObjectObjectRelation [

	writeBuilder provenance: aMOObjectObjectRelation
]
