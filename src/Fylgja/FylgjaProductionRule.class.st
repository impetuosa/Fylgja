Class {
	#name : #FylgjaProductionRule,
	#superclass : #FylgjaRule,
	#category : #'Fylgja-Rules'
}

{ #category : #'as yet unclassified' }
FylgjaProductionRule >> isProductionRule [

	^ true
]

{ #category : #testing }
FylgjaProductionRule >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ (operation
		   canBeAppliedTo: aProvenanceEntityRelation
		   context: aDestinationContextRelation
		   forProducing: aType
		   with: aWriter) and: (condition
			   matches: aProvenanceEntityRelation
			   context: aDestinationContextRelation
			   forWriting: aType
			   with: aWriter)
]

{ #category : #'as yet unclassified' }
FylgjaProductionRule >> printingSymbol [

	^ '=>>'
]
