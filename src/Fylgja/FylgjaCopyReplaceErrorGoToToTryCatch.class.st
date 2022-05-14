Class {
	#name : #FylgjaCopyReplaceErrorGoToToTryCatch,
	#superclass : #FylgjaTranslation,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceErrorGoToToTryCatch class >> possibleWritingMessages [

	^ { #writeBlock: }
]

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceErrorGoToToTryCatch >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| statmentRelations blockStatements tryStatements catchStatements indexOfLabel onErrorGoTo |
	statmentRelations := aProvenanceEntityRelation to relationsNamed:
		                     #statements.

	onErrorGoTo := (statmentRelations detect: [ :a | 
		                a to isKindOf: MOAlceOnErrorGoToLabel ]) to.

	indexOfLabel := statmentRelations detectIndex: [ :a | 
		                a to isLabelledAs: onErrorGoTo destination name ].

	blockStatements := aBlock value: (statmentRelations
			                    copyFrom: 1
			                    to:
			                    (aProvenanceEntityRelation to statements 
				                     indexOf: onErrorGoTo) - 1).

	tryStatements := aBlock value: (statmentRelations
			                  copyFrom:
			                  (aProvenanceEntityRelation to statements 
				                   indexOf: onErrorGoTo) + 1
			                  to: indexOfLabel - 2).
	catchStatements := aBlock value: (statmentRelations
			                    copyFrom: indexOfLabel + 1
			                    to:
			                    aProvenanceEntityRelation to statements size).

	^ aDestinationWriter writeBlock: [ :block | 
		  blockStatements do: [ :s | 
			  aFylgjaDerivativeModel
				  migrate: s
				  croppingRelationsWith: aBlock
				  intoDestinationWriter: block
				  lookUp: aFylgjaLookUpContext ].
			
			
		  block writeTryCatch: [ :tryCatch | 
			  tryCatch writeTry: [ :try | 
				  tryStatements do: [ :s | 
					  aFylgjaDerivativeModel
						  migrate: s
						  croppingRelationsWith: aBlock
						  intoDestinationWriter: try
						  lookUp: aFylgjaLookUpContext ] ].
			  tryCatch writeCatch: [ :catch | 
				  catch writeParameter: [ :e | 
					  e
						  name: 'error';
						  typeReference: (e typeReferenceNamed: #Exception) ].
				  catch writeBlock: [ :catchBlock | 
					  catchStatements do: [ :s | 
						  aFylgjaDerivativeModel
							  migrate: s
							  croppingRelationsWith: aBlock
							  intoDestinationWriter: catchBlock
							  lookUp: aFylgjaLookUpContext ] ] ] ] ]
]

{ #category : #testing }
FylgjaCopyReplaceErrorGoToToTryCatch >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isMOBlock and: [ 
		  self canWriteOver: aWriter ]
]

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceErrorGoToToTryCatch >> printOn: aStream [
 	aStream nextPutAll: 'Replace On Error with Try catch'
]
