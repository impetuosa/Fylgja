Extension { #name : #MODeclaration }

{ #category : #'*Fylgja' }
MODeclaration >> isFylgjaStub [

	^ false
]

{ #category : #'*Fylgja' }
MODeclaration >> resolveModelUsing: aFylgjaMigrationEngine [

	^ aFylgjaMigrationEngine selectDerivativeModelFor: self
]
