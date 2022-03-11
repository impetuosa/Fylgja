Class {
	#name : #FylgjaCandidateStubBuilder,
	#superclass : #MOModelBuilderDelegate,
	#instVars : [
		'originalCandidate'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #'as yet unclassified' }
FylgjaCandidateStubBuilder >> buildsType [

	^ originalCandidate
		  ifNil: [ FylgjaMissingCandidateStub ]
		  ifNotNil: [ FylgjaCandidateStub ]
]

{ #category : #accessing }
FylgjaCandidateStubBuilder >> loadBuilderWithEntity: anEntity [

	self error: ' Whut? '
]

{ #category : #accessing }
FylgjaCandidateStubBuilder >> originalCandidate [

	^ originalCandidate
]

{ #category : #'as yet unclassified' }
FylgjaCandidateStubBuilder >> originalCandidate: anElement [

	originalCandidate := anElement
]

{ #category : #accessing }
FylgjaCandidateStubBuilder >> privateBuild [

	| instance |
	instance := self instantiate: self buildsType.
	self originalCandidate ifNotNil: [ 
		instance originalCandidate: self originalCandidate ].
	^ instance
]
