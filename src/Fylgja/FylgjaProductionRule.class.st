Class {
	#name : #FylgjaProductionRule,
	#superclass : #FylgjaRule,
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaProductionRule >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [

	^ condition
		  matches: aProvenanceEntityRelation
		  context: aDestinationContextRelation
		  forWriting: aType
]

{ #category : #'as yet unclassified' }
FylgjaProductionRule >> printingSymbol [

	^ '=>>'
]
