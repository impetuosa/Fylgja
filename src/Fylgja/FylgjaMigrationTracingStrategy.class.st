Class {
	#name : #FylgjaMigrationTracingStrategy,
	#superclass : #Object,
	#category : #'Fylgja-Model'
}

{ #category : #'as yet unclassified' }
FylgjaMigrationTracingStrategy >> trace: provenance to: desintationContext produced: destination [

	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
FylgjaMigrationTracingStrategy >> traces [
	self subclassResponsibility 
]
