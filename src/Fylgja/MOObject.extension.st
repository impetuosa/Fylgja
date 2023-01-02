Extension { #name : #MOObject }

{ #category : #'*Fylgja' }
MOObject >> isFylgjaStub [

	^ false
]

{ #category : #'*Fylgja' }
MOObject >> resolveModelUsing: aFylgjaMigrationEngine [

	^ aFylgjaMigrationEngine selectDerivativeModelFor: self
]
