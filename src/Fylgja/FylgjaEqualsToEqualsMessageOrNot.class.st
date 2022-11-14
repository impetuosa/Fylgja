Class {
	#name : #FylgjaEqualsToEqualsMessageOrNot,
	#superclass : #FylgjaStaticProductionRule,
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaEqualsToEqualsMessageOrNot >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| relations |
	relations := aRelatedProvenanceEntity to allRelations.
	^ aDestinationWriter
		  invokeMethodNamed: #equals
		  receiver: [ :r | 
			  FylgjaCopy new
				  lookUp: aFylgjaLookUpContext;
				  fylgja: aFylgjaDerivativeModel;
				  provenanceRelation: (relations detect: [ :e | e name = #left ]);
				  cropping: aBlock;
				  applyOn: r ]
		  arguments: [ :r | 
			  { (FylgjaCopy new
				   lookUp: aFylgjaLookUpContext;
				   fylgja: aFylgjaDerivativeModel;
				   provenanceRelation:
					   (relations detect: [ :e | e name = #right ]);
				   cropping: aBlock;
				   applyOn: r) } ]
]

{ #category : #testing }
FylgjaEqualsToEqualsMessageOrNot >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ (aProvenanceEntityRelation to isKindOf: MOBinaryOperation) and: [ 
		  #( = Is ) includes: aProvenanceEntityRelation to operator ]
]
