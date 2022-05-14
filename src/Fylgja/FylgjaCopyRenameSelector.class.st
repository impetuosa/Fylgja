Class {
	#name : #FylgjaCopyRenameSelector,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'name'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaCopyRenameSelector >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

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
FylgjaCopyRenameSelector >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ (aProvenanceEntityRelation to isInvocable and: [ 
		   aProvenanceEntityRelation to isFunction or: [ 
			   aProvenanceEntityRelation to isProcedure ] ]) and: [ 
		  aType canUnderstand: #selector: ]
]

{ #category : #accessing }
FylgjaCopyRenameSelector >> name: aString [ 
	name := aString
]
