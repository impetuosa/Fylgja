Class {
	#name : #FylgjaCopyReplaceTypeReference,
	#superclass : #FylgjaTranslation,
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceTypeReference >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ aDestinationWriter typeReferenceNamed:
		  aProvenanceEntityRelation to name
]

{ #category : #'as yet unclassified' }
FylgjaCopyReplaceTypeReference >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isTypeReference
]
