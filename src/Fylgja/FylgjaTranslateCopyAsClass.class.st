Class {
	#name : #FylgjaTranslateCopyAsClass,
	#superclass : #FylgjaTranslation,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsClass >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ aDestinationWriter writeDeclarationUnit: [ :unit | 
		  unit writeClass: [ :class | 
			  class visibility: #public.
			  class name: aProvenanceEntityRelation name.
			  FylgjaCopy new
				  lookUp: aFylgjaLookUpContext;
				  fylgja: aFylgjaDerivativeModel;
				  provenanceRelation: aProvenanceEntityRelation;
				  cropping: [ :col | 
					  (aBlock value: col) select: [ :relation | 
							  relation isMOObject not or: [ 
									  relation to isVariable or: [ relation to isInvocable ] ] ] ];
				  applyOn: class ] ]
]
