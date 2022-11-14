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
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsAttribute class >> possibleWritingMessages [

	^ { #writeConstantAttribute:. #writeAttribute: }
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsAttribute >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	writer := aDestinationWriter.
	relation := aProvenanceEntityRelation.
	lookup := aFylgjaLookUpContext.
	using := aFylgjaDerivativeModel.
	croppingBlock := aBlock.
	[ ^ aProvenanceEntityRelation to acceptVisitor: self ] ensure: [ 
		writer := nil.
		relation := nil.
		lookup := nil.
		using := nil.
		croppingBlock := nil ]
]

{ #category : #testing }
FylgjaTranslateCopyAsAttribute >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isVariable and: [ 
		  self canWriteOver: aWriter ]
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
