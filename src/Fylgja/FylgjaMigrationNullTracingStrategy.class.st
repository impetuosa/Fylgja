Class {
	#name : #FylgjaMigrationNullTracingStrategy,
	#superclass : #FylgjaMigrationTracingStrategy,
	#category : #'Fylgja-Model'
}

{ #category : #'as yet unclassified' }
FylgjaMigrationNullTracingStrategy >> activateTracing [

	^ FylgjaMigrationLedgerTracingStrategy new
]

{ #category : #'as yet unclassified' }
FylgjaMigrationNullTracingStrategy >> noTracing [

	^ self 
]

{ #category : #'as yet unclassified' }
FylgjaMigrationNullTracingStrategy >> trace: provenance to: desintationContext produced: destination [
	" nothing todo "
]

{ #category : #'as yet unclassified' }
FylgjaMigrationNullTracingStrategy >> traces [
	^ {  }
]
