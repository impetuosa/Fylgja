Class {
	#name : #FylgjaTranslateCopyAsTypescriptClass,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'provenanceEntityRelation',
		'croppingRelationsWith',
		'lookUp',
		'using'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsTypescriptClass >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| result |
	provenanceEntityRelation := aProvenanceEntityRelation.
	croppingRelationsWith := aBlock.
	lookUp := aFylgjaLookUpContext.
	using := aFylgjaDerivativeModel.
	
	result := aDestinationWriter acceptWritingVisitor: self.
	
	provenanceEntityRelation := nil.
	croppingRelationsWith := nil.
	lookUp := nil.
	using := nil.
	^ result
]

{ #category : #visiting }
FylgjaTranslateCopyAsTypescriptClass >> visitAngularModuleWriter: aMOAngularModuleWriter [

	^ aMOAngularModuleWriter writeDeclarationUnit: [ :unit | 
		  unit acceptWritingVisitor: self ]
]

{ #category : #visiting }
FylgjaTranslateCopyAsTypescriptClass >> visitUnitWriter: unit [

	^ unit writeTypescriptClass: [ :class | 
		  class visibility: #public.
		  class name: provenanceEntityRelation name.
		  FylgjaCopy new
			  lookUp: lookUp;
			  fylgja: using;
			  provenanceRelation: provenanceEntityRelation;
			  cropping: [ :col | 
				  (croppingRelationsWith value: col) select: [ :relation | 
						  relation isMOObject not or: [ 
								  relation to isVariable or: [ relation to isInvocable ] ] ] ];
			  applyOn: class ]
]
