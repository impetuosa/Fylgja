Class {
	#name : #FylgjaAbstractCandidateStub,
	#superclass : #MOReference,
	#instVars : [
		'#provenance => MOPropertySlot'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #testing }
FylgjaAbstractCandidateStub >> canBeReferredAsArrayAccess [

	^ true
]

{ #category : #testing }
FylgjaAbstractCandidateStub >> canBeReferredAsAttribute [

	^ true
]

{ #category : #testing }
FylgjaAbstractCandidateStub >> canBeReferredAsConstant [

	^ true
]

{ #category : #testing }
FylgjaAbstractCandidateStub >> canBeReferredAsConstructor [

	^ true
]

{ #category : #testing }
FylgjaAbstractCandidateStub >> canBeReferredAsFunction [

	^ true
]

{ #category : #testing }
FylgjaAbstractCandidateStub >> canBeReferredAsLabel [

	^ true
]

{ #category : #testing }
FylgjaAbstractCandidateStub >> canBeReferredAsMethod [

	^ true
]

{ #category : #testing }
FylgjaAbstractCandidateStub >> canBeReferredAsPrimitiveType [

	^ true
]

{ #category : #testing }
FylgjaAbstractCandidateStub >> canBeReferredAsType [

	^ true
]

{ #category : #testing }
FylgjaAbstractCandidateStub >> canBeReferredAsVariable [

	^ true
]

{ #category : #'as yet unclassified' }
FylgjaAbstractCandidateStub >> canbeReferredAsSelf [

	^ true
]

{ #category : #testing }
FylgjaAbstractCandidateStub >> isFylgjaStub [

	^ true
]

{ #category : #'as yet unclassified' }
FylgjaAbstractCandidateStub >> isTypeReference [

	^ provenance to isNotNil and: [ provenance to isTypeReference ]
]

{ #category : #'as yet unclassified' }
FylgjaAbstractCandidateStub >> name [

	^ provenance to name
]

{ #category : #accessing }
FylgjaAbstractCandidateStub >> packageReference [

	^ nil
]

{ #category : #'as yet unclassified' }
FylgjaAbstractCandidateStub >> provenance [
	^ provenance 
]

{ #category : #'as yet unclassified' }
FylgjaAbstractCandidateStub >> provenance: aMOObjectObjectRelation [

	provenance := aMOObjectObjectRelation
]

{ #category : #accessing }
FylgjaAbstractCandidateStub >> typeReference [

	^ nil
]
