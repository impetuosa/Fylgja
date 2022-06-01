Class {
	#name : #FylgjaTranslateCopyAsClass,
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
FylgjaTranslateCopyAsClass >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| resp |
	provenanceEntityRelation := aProvenanceEntityRelation.
	croppingRelationsWith := aBlock.
	lookUp := aFylgjaLookUpContext.
	using := aFylgjaDerivativeModel.

	resp := aDestinationWriter acceptWritingVisitor: self.




	provenanceEntityRelation := nil.
	croppingRelationsWith := nil.
	lookUp := nil.
	using := nil.
	^ resp
]

{ #category : #testing }
FylgjaTranslateCopyAsClass >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isModule and: [ 
		  self canWriteOver: aWriter ]
]

{ #category : #visiting }
FylgjaTranslateCopyAsClass >> possibleWritingMessages [ 

	^{ #writeDeclarationUnit: . #writeClass:}
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsClass >> printOn: aStream [
 	aStream nextPutAll: 'Transform into Class'
]

{ #category : #visiting }
FylgjaTranslateCopyAsClass >> visitPackageWriter: aMOPackageWriter [

	^ aMOPackageWriter writeDeclarationUnit: [ :unit | 
		  unit acceptWritingVisitor: self ]
]

{ #category : #visiting }
FylgjaTranslateCopyAsClass >> visitUnitWriter: unit [

	^ unit writeClass: [ :class | 
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
