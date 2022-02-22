Class {
	#name : #FylgjaMigrationTracingStrategy,
	#superclass : #Object,
	#category : #'Fylgja-Tracing'
}

{ #category : #'as yet unclassified' }
FylgjaMigrationTracingStrategy >> trace: provenance to: aRule produced: destination [

	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
FylgjaMigrationTracingStrategy >> traces [
	self subclassResponsibility 
]
