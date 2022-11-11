Class {
	#name : #FylgjaCandidateStubBuilder,
	#superclass : #MOModelBuilderDelegate,
	#instVars : [
		'candidate',
		'parent',
		'provenance'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #'as yet unclassified' }
FylgjaCandidateStubBuilder >> buildsType [

	^ candidate
		  ifNil: [ FylgjaMissingCandidateStub ]
		  ifNotNil: [ FylgjaCandidateStub ]
]

{ #category : #accessing }
FylgjaCandidateStubBuilder >> loadBuilderWithEntity: anEntity [

	self error: ' Whut? '
]

{ #category : #accessing }
FylgjaCandidateStubBuilder >> parent [
	^ parent
]

{ #category : #accessing }
FylgjaCandidateStubBuilder >> parent: aMOPrimitiveTypeReference [ 
	parent := aMOPrimitiveTypeReference
]

{ #category : #accessing }
FylgjaCandidateStubBuilder >> privateBuild [

	| instance |
	instance := self instantiate: self buildsType.
	instance provenance: self provenance.
	instance parent: self parent. 
	self referee ifNotNil: [ instance referee: self referee ].

	^ instance
]

{ #category : #accessing }
FylgjaCandidateStubBuilder >> provenance [
	 ^ provenance ifNil: [ self error: ' Cannot build a stub without provenance ' ]
]

{ #category : #'as yet unclassified' }
FylgjaCandidateStubBuilder >> provenance: aMOObjectObjectRelation [

	provenance := aMOObjectObjectRelation
]

{ #category : #accessing }
FylgjaCandidateStubBuilder >> referee [

	^ candidate
]

{ #category : #accessing }
FylgjaCandidateStubBuilder >> referee: aCandidate [ 

	 candidate := aCandidate 
]
