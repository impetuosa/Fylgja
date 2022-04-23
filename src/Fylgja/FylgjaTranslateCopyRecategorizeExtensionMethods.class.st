Class {
	#name : #FylgjaTranslateCopyRecategorizeExtensionMethods,
	#superclass : #FylgjaTranslation,
	#category : #'Fylgja-Test-VWPharo'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyRecategorizeExtensionMethods >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [
  | unit |
  unit := self writeCopyOf: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja.
  unit extensionMethods do: [:em |  em category: '*' , unit packageReference name ].
  ^unit
]
