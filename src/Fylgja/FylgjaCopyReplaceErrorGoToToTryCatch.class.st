Class {
	#name : #FylgjaCopyReplaceErrorGoToToTryCatch,
	#superclass : #FylgjaTranslate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceErrorGoToToTryCatch >> applyTo: aProvenanceEntityRelation destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| statmentRelations blockStatements tryStatements catchStatements indexOfLabel onErrorGoTo |
	
	statmentRelations := aProvenanceEntityRelation to relationsNamed: #statements. 
	
	onErrorGoTo :=( statmentRelations detect: [ :a | 
		               a to isKindOf: MOAlceOnErrorGoToLabel ]) to .

	indexOfLabel :=statmentRelations detectIndex: [ :a | 
		                a to isLabelledAs: onErrorGoTo destination name ].

	blockStatements := statmentRelations
		                   copyFrom: 1
		                   to:
		                   (aProvenanceEntityRelation to statements indexOf:
			                    onErrorGoTo) - 1.

	tryStatements := statmentRelations
		                 copyFrom:
		                 (aProvenanceEntityRelation to statements indexOf: onErrorGoTo)
		                 + 1
		                 to: indexOfLabel - 2.
	catchStatements := statmentRelations
		                   copyFrom: indexOfLabel + 1
		                   to: aProvenanceEntityRelation to  statements size.



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
