Class {
	#name : #FylgjaAbstractCandidateStub,
	#superclass : #MOReference,
	#instVars : [
		'provenance'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #testing }
FylgjaAbstractCandidateStub >> canBeReferredAsVariable [

	^ true
]

{ #category : #testing }
FylgjaAbstractCandidateStub >> isFylgjaStub [

	^ true
]

{ #category : #'as yet unclassified' }
FylgjaAbstractCandidateStub >> isTypeReference [

	^ provenance to isTypeReference
]

{ #category : #'as yet unclassified' }
FylgjaAbstractCandidateStub >> name [

	^ provenance to name
]

{ #category : #'as yet unclassified' }
FylgjaAbstractCandidateStub >> provenance [
	^ provenance 
]

{ #category : #'as yet unclassified' }
FylgjaAbstractCandidateStub >> provenance: aMOObjectObjectRelation [

	provenance := aMOObjectObjectRelation
]
