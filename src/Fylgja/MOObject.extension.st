Extension { #name : #MOObject }

{ #category : #'*Fylgja' }
MOObject >> resolveModelUsing: aFylgjaMigrationEngine [

	^ aFylgjaMigrationEngine selectDerivativeModelFor: self
]
