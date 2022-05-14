Class {
	#name : #FylgjaTranslateCopyReplaceCategory,
	#superclass : #FylgjaTranslation,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyReplaceCategory >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| copy |
	copy := self
		        writeCopyOf: aRelatedProvenanceEntity
		        croppingRelationsWith: aBlock
		        destinationWriter: aDestinationWriter
		        lookUp: aFylgjaLookUpContext
		        using: aFylgjaDerivativeModel.
	copy category: aDestinationWriter name.
	^ copy
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyReplaceCategory >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aType canUnderstand: #category:
]
