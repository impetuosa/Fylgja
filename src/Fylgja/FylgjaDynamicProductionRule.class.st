Class {
	#name : #FylgjaDynamicProductionRule,
	#superclass : #FylgjaDynamicRule,
	#category : #'Fylgja-Rules'
}

{ #category : #'as yet unclassified' }
FylgjaDynamicProductionRule >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ operation
		  applyTo: aRelatedProvenanceEntity
		  croppingRelationsWith: aBlock
		  destinationWriter: aDestinationWriter
		  lookUp: aFylgjaLookUpContext
		  using: aFylgjaDerivativeModel
]

{ #category : #'as yet unclassified' }
FylgjaDynamicProductionRule >> isProductionRule [

	^ true
]

{ #category : #testing }
FylgjaDynamicProductionRule >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ (operation
		   canBeAppliedTo: aProvenanceEntityRelation
		   context: aDestinationContextRelation
		   forProducing: aType
		   with: aWriter) and: [ 
		  condition
			  matches: aProvenanceEntityRelation
			  context: aDestinationContextRelation
			  forWriting: aType
			  with: aWriter ]
]

{ #category : #'as yet unclassified' }
FylgjaDynamicProductionRule >> printingSymbol [

	^ '=>>'
]
