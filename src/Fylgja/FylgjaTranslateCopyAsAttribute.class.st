Class {
	#name : #FylgjaTranslateCopyAsAttribute,
	#superclass : #FylgjaTranslate,
	#instVars : [
		'writer',
		'relation',
		'lookup',
		'using'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsAttribute >> applyTo: aProvenanceEntityRelation destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	writer := aDestinationWriter.
	relation := aProvenanceEntityRelation.
	lookup := aFylgjaLookUpContext.
	using := aFylgjaDerivativeModel.
	^ aProvenanceEntityRelation to acceptVisitor: self
]

{ #category : #visiting }
FylgjaTranslateCopyAsAttribute >> keepCopyingWith: aWriter [

	^ aWriter writeCopyOf: relation readingValues: [ :context :value | 
		  using migrate: value intoDestinationWriter: aWriter lookUp: lookup ]
]

{ #category : #printing }
FylgjaTranslateCopyAsAttribute >> printOn: aStream [
 	aStream nextPutAll: 'CopyAsAttribute'
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
		  self keepCopyingWith: attribute. 
		]
]
