Class {
	#name : #FylgjaMissingCandidateStub,
	#superclass : #FylgjaAbstractCandidateStub,
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #accessing }
FylgjaMissingCandidateStub >> acceptVisitor: aMOJavaCodeGenerator [

	^ self provenance to acceptVisitor: aMOJavaCodeGenerator
]

{ #category : #printing }
FylgjaMissingCandidateStub >> printOn: aStream [

	aStream
		nextPutAll: 'Fylgja: MISSING CANDIDATE';
		print: candidate
]
