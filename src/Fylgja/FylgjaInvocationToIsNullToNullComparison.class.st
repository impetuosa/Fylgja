Class {
	#name : #FylgjaInvocationToIsNullToNullComparison,
	#superclass : #FylgjaStaticProductionRule,
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaInvocationToIsNullToNullComparison >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ aDestinationWriter
		  operate: [ :w | 
			  FylgjaMigrate new
				  cropping: aBlock;
				  fylgja: aFylgjaDerivativeModel;
				  lookUp: aFylgjaLookUpContext;
				  provenanceEntity: aRelatedProvenanceEntity to arguments first;
				  applyOn: w ]
		  operator: #==
		  with: [ :w | w nullLiteral ]
]

{ #category : #testing }
FylgjaInvocationToIsNullToNullComparison >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ aProvenanceEntityRelation to isInvocation and: [ 
		  aProvenanceEntityRelation to selector = #IsNull and: [ 
			  aProvenanceEntityRelation to arguments size = 1 ] ]
]
