Class {
	#name : #FylgjaMigrationLedgerTracingStrategy,
	#superclass : #FylgjaMigrationTracingStrategy,
	#instVars : [
		'traces'
	],
	#category : #'Fylgja-Model'
}

{ #category : #'as yet unclassified' }
FylgjaMigrationLedgerTracingStrategy >> activateTracing [ 
	^ self 
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLedgerTracingStrategy >> noTracing [

	^ FylgjaMigrationNullTracingStrategy new
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLedgerTracingStrategy >> trace: provenance to: desintationContext produced: destination [

	self traces add: { 
			provenance.
			desintationContext.
			destination }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLedgerTracingStrategy >> traces [

	^ traces ifNil: [ traces := OrderedCollection new ]
]
