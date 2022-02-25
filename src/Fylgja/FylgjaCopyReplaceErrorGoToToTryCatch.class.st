Class {
	#name : #FylgjaCopyReplaceErrorGoToToTryCatch,
	#superclass : #FylgjaTranslate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceErrorGoToToTryCatch >> applyTo: aRelatedProvenanceEntity destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| blockStatements tryStatements catchStatements indexOfLabel onErrorGoTo |
	onErrorGoTo := aRelatedProvenanceEntity statements detect: [ :a | 
		               a isKindOf: MOAlceOnErrorGoToLabel ].

	indexOfLabel := aRelatedProvenanceEntity statements detectIndex: [ :a | 
		                a isLabelledAs: onErrorGoTo destination name ].

	blockStatements := aRelatedProvenanceEntity statements
		                   copyFrom: 1
		                   to:
		                   (aRelatedProvenanceEntity statements indexOf:
			                    onErrorGoTo) - 1.

	tryStatements := aRelatedProvenanceEntity statements
		                 copyFrom:
		                 (aRelatedProvenanceEntity statements indexOf: onErrorGoTo)
		                 + 1
		                 to: indexOfLabel - 2.
	catchStatements := aRelatedProvenanceEntity statements
		                   copyFrom: indexOfLabel + 1
		                   to: aRelatedProvenanceEntity statements size.



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
