Class {
	#name : #FylgjaTranslateCopyAsAttribute,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'writer',
		'relation',
		'lookup',
		'using',
		'croppingBlock'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsAttribute >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	writer := aDestinationWriter.
	relation := aProvenanceEntityRelation.
	lookup := aFylgjaLookUpContext.
	using := aFylgjaDerivativeModel.
	croppingBlock := aBlock.
	^ aProvenanceEntityRelation to acceptVisitor: self
]

{ #category : #visiting }
FylgjaTranslateCopyAsAttribute >> keepCopyingWith: aWriter [

	^ FylgjaCopy new
		  lookUp: lookup;
		  fylgja: using;
		  provenanceRelation: relation;
		  cropping: croppingBlock;
		  applyOn: aWriter
]

{ #category : #printing }
FylgjaTranslateCopyAsAttribute >> printOn: aStream [
 	aStream nextPutAll: 'Transform into Attribute'
]

{ #category : #visiting }
FylgjaTranslateCopyAsAttribute >> visitGlobalConstant: aMOGlobalConstant [

	^ writer writeConstantAttribute: [ :attribute | 
		  attribute setStaticBinding.
		  attribute name: aMOGlobalConstant name.
		  attribute typeReferenceNamed: aMOGlobalConstant typeReference name.
		  self keepCopyingWith: attribute ]
]

{ #category : #visiting }
FylgjaTranslateCopyAsAttribute >> visitGlobalVariable: aMOGlobalVariable [

	^ writer writeAttribute: [ :attribute | 
		  attribute setStaticBinding.
		  attribute name: aMOGlobalVariable name.
		  attribute typeReferenceNamed: aMOGlobalVariable typeReference name.
		  self keepCopyingWith: attribute ]
]
