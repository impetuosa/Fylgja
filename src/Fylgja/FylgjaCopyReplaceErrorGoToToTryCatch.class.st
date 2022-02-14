Class {
	#name : #FylgjaCopyReplaceErrorGoToToTryCatch,
	#superclass : #FylgjaTranslate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceErrorGoToToTryCatch >> applyTo: aProvenanceElement context: aDestinationContext using: aFylgjaDerivativeModel [

	| blc rest blockStatements tryStatements catchStatements indexOfLabel tryBlock catchBlock onErrorGoTo |
	onErrorGoTo := aProvenanceElement statements detect: [ :a | 
		               a isKindOf: MOAlceOnErrorGoToLabel ].

	indexOfLabel := aProvenanceElement statements detectIndex: [:a | 
		         a isLabelledAs: onErrorGoTo destination name ].
	
	blockStatements := aProvenanceElement statements copyFrom: 1  to: (aProvenanceElement statements indexOf: onErrorGoTo) -1 .
	
	tryStatements := aProvenanceElement statements copyFrom:  (aProvenanceElement statements indexOf: onErrorGoTo)+ 1  to: indexOfLabel-2.
	catchStatements := aProvenanceElement statements copyFrom:  indexOfLabel + 1   to: aProvenanceElement statements size. 
	

	aFylgjaDerivativeModel
		writerFor: aProvenanceElement
		inContextOf: aDestinationContext
		do: [ :writingEntity :contextWriter | 
			contextWriter writeBlock: [ :block | 
				block writeTryCatch: [ :tryCatch | 
					tryCatch writeTry: [ :try | try onBuild: [ :b | tryBlock := b ] ].
					tryCatch writeCatch: [ :catch | 
						catch writeParameter: [ :e | 
							e
								name: 'error';
								typeReference: (e typeReferenceNamed: #Exception) ].
						catch writeBlock: [ :b | b onBuild: [ :c | catchBlock := c ] ] ] ].
				block onBuild: [ :m | blc := m ] ] ].
	tryStatements do: [ :s | 
		aFylgjaDerivativeModel migrate: s into: tryBlock ].
	catchStatements do: [ :s | 
		aFylgjaDerivativeModel migrate: s into: catchBlock ].
	^ blc
]
