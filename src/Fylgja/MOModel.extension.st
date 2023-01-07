Extension { #name : #MOModel }

{ #category : #'*Fylgja' }
MOModel >> allStubs [

	^ self stubs
]

{ #category : #'*Fylgja' }
MOModel >> resolveModelUsing: aFylgjaMigrationEngine [

	^ aFylgjaMigrationEngine models detect: [ :m | m realModel = self ]
]

{ #category : #'*Fylgja' }
MOModel >> stubs [
	^ self entities select: [ : a | a isFylgjaStub ]
]
