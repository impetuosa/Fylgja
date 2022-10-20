Class {
	#name : #FylgjaDateLiteralToLocaleDateParse,
	#superclass : #FylgjaStaticProductionRule,
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaDateLiteralToLocaleDateParse >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| literal dateString |
	literal := aRelatedProvenanceEntity to literal
		           copyReplaceAll: '#'
		           with: ''.
	literal := '/' split: literal.
	literal size = 1
		ifFalse: [ 
			dateString := '{1}-{2}-{3}' format: { 
					              literal third.
					              (self twoDigits: literal second).
					              (self twoDigits: literal first) } ]
		ifTrue: [ dateString := literal first ].
	^ aDestinationWriter
		  invokeMethodNamed: #parse
		  receiver: [ :r | 
			  (r typeReferenceNamed: #LocalDate)
				  candidate: (r model typeNamed: #LocalDate);
				  yourself ]
		  arguments: [ :r | { (r stringLiteral: dateString) } ]
]

{ #category : #testing }
FylgjaDateLiteralToLocaleDateParse >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ aProvenanceEntityRelation to isKindOf: MOAlceDateLiteral
]

{ #category : #testing }
FylgjaDateLiteralToLocaleDateParse >> twoDigits: aNumber [

	^ (aNumber asNumber < 10
		   ifTrue: [ '0' ]
		   ifFalse: [ '' ]) , aNumber asString
]
