Class {
	#name : #FylgjaCandidateStub,
	#superclass : #FylgjaAbstractCandidateStub,
	#instVars : [
		'#originalCandidate => MOPropertySlot'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #accessing }
FylgjaCandidateStub >> originalCandidate: aMOPrimitiveType [ 
	originalCandidate := aMOPrimitiveType
]
