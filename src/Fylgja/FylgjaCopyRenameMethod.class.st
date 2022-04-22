Class {
	#name : #FylgjaCopyRenameMethod,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'name'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaCopyRenameMethod >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	^ (self
		   writeCopyOf: aRelatedProvenanceEntity
			croppingRelationsWith: aBlock 
		   destinationWriter: aDestinationWriter
		   lookUp: aFylgjaLookUpContext
		   using: aFylgja)
			selector: name;
		  yourself
]

{ #category : #accessing }
FylgjaCopyRenameMethod >> name: aString [ 
	name := aString
]
