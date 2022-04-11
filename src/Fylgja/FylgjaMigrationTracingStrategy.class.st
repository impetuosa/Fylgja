Class {
	#name : #FylgjaMigrationTracingStrategy,
	#superclass : #Object,
	#category : #'Fylgja-Tracing'
}

{ #category : #accessing }
FylgjaMigrationTracingStrategy >> swap: aFylgjaCandidateStub with: aMOVariableReference [

	self assert: aFylgjaCandidateStub parent = aMOVariableReference
]

{ #category : #'as yet unclassified' }
FylgjaMigrationTracingStrategy >> trace: provenance to: aRule produced: destination [

	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
FylgjaMigrationTracingStrategy >> traces [
	self subclassResponsibility 
]
