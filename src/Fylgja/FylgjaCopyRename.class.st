Class {
	#name : #FylgjaCopyRename,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'name'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaCopyRename >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	^ (self
		   writeCopyOf: aRelatedProvenanceEntity
			croppingRelationsWith: aBlock 
		   destinationWriter: aDestinationWriter
		   lookUp: aFylgjaLookUpContext
		   using: aFylgja)
			name: name;
		  yourself
]

{ #category : #accessing }
FylgjaCopyRename >> name: aString [ 
	name := aString
]
