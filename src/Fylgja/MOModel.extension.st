Extension { #name : #MOModel }

{ #category : #'*Fylgja' }
MOModel >> resolveModelUsing: aFylgjaMigrationEngine [

	self assert: (aFylgjaMigrationEngine models includes: self).
	^ self
]
