Class {
	#name : #FylgjaMigrationNullTracingStrategy,
	#superclass : #FylgjaMigrationTracingStrategy,
	#category : #'Fylgja-Tracing'
}

{ #category : #'as yet unclassified' }
FylgjaMigrationNullTracingStrategy >> activateTracing [

	^ FylgjaMigrationLedgerTracingStrategy new
]

{ #category : #'as yet unclassified' }
FylgjaMigrationNullTracingStrategy >> noTracing [

	^ self 
]

{ #category : #accessing }
FylgjaMigrationNullTracingStrategy >> swap: aFylgjaCandidateStub with: aMOVariableReference [ 
	 " nothing to do "
]

{ #category : #'as yet unclassified' }
FylgjaMigrationNullTracingStrategy >> trace: provenance to: aRule produced: destination [
	" nothing todo "
]

{ #category : #'as yet unclassified' }
FylgjaMigrationNullTracingStrategy >> traces [
	^ {  }
]
