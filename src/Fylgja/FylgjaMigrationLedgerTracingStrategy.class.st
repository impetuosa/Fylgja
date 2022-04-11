Class {
	#name : #FylgjaMigrationLedgerTracingStrategy,
	#superclass : #FylgjaMigrationTracingStrategy,
	#instVars : [
		'traces'
	],
	#category : #'Fylgja-Tracing'
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
FylgjaMigrationLedgerTracingStrategy >> trace: provenance to: aRule produced: destination [

	self traces add: { 
			provenance.
			aRule.
			destination }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLedgerTracingStrategy >> traces [

	^ traces ifNil: [ traces := OrderedCollection new ]
]
