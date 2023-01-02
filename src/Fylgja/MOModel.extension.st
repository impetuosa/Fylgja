Extension { #name : #MOModel }

{ #category : #'*Fylgja' }
MOModel >> allStubs [

	^ self stubs
]

{ #category : #'*Fylgja' }
MOModel >> resolveModelUsing: aFylgjaMigrationEngine [

	self assert: (aFylgjaMigrationEngine models includes: self).
	^ self
]

{ #category : #'*Fylgja' }
MOModel >> stubs [
	^ self entities select: [ : a | a isFylgjaStub ]
]
