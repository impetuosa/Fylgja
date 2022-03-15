Class {
	#name : #FylgjaBindRewrite,
	#superclass : #FylgjaBinding,
	#instVars : [
		'destinationEntity'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaBindRewrite >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	| produced |
	produced := self
		            writeCopyOf: aRelatedProvenanceEntity
		            croppingRelationsWith: aBlock
		            destinationWriter: aDestinationWriter
		            lookUp: aFylgjaLookUpContext
		            using: aFylgja.
	produced candidate: destinationEntity.
	^ produced
]

{ #category : #'as yet unclassified' }
FylgjaBindRewrite >> destinationEntity: aDestinationEntity [

	destinationEntity := aDestinationEntity
]
