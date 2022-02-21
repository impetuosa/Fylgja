Class {
	#name : #FylgjaCopyReplaceErrorGoToToTryCatch,
	#superclass : #FylgjaTranslate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceErrorGoToToTryCatch >> applyTo: aProvenanceElement destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| blockStatements tryStatements catchStatements indexOfLabel onErrorGoTo |
	onErrorGoTo := aProvenanceElement statements detect: [ :a | 
		               a isKindOf: MOAlceOnErrorGoToLabel ].

	indexOfLabel := aProvenanceElement statements detectIndex: [ :a | 
		                a isLabelledAs: onErrorGoTo destination name ].

	blockStatements := aProvenanceElement statements
		                   copyFrom: 1
		                   to:
		                   (aProvenanceElement statements indexOf:
			                    onErrorGoTo) - 1.

	tryStatements := aProvenanceElement statements
		                 copyFrom:
		                 (aProvenanceElement statements indexOf: onErrorGoTo)
		                 + 1
		                 to: indexOfLabel - 2.
	catchStatements := aProvenanceElement statements
		                   copyFrom: indexOfLabel + 1
		                   to: aProvenanceElement statements size.



	^ aDestinationWriter writeBlock: [ :block | 
		  block writeTryCatch: [ :tryCatch | 
			  tryCatch writeTry: [ :try | 
				  tryStatements do: [ :s | 
					  aFylgjaDerivativeModel
						  migrate: s
						  intoDestinationWriter: try
						  lookUp: aFylgjaLookUpContext ] ].
			  tryCatch writeCatch: [ :catch | 
				  catch writeParameter: [ :e | 
					  e
						  name: 'error';
						  typeReference: (e typeReferenceNamed: #Exception) ].
				  catch writeBlock: [ :catchBlock | 
					  tryStatements do: [ :s | 
						  aFylgjaDerivativeModel
							  migrate: s
							  intoDestinationWriter: catchBlock
							  lookUp: aFylgjaLookUpContext ] ] ] ] ]
]
