Class {
	#name : #FylgjaCopyRename,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'name'
	],
	#category : #'Fylgja-Rule-Translation'
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

{ #category : #'as yet unclassified' }
FylgjaCopyRename >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aType isRenamable
]

{ #category : #accessing }
FylgjaCopyRename >> name: aString [ 
	name := aString
]
