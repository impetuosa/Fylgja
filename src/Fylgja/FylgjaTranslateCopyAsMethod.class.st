Class {
	#name : #FylgjaTranslateCopyAsMethod,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'writer',
		'mustReturn'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| method |
	mustReturn := false.
	method := aDestinationWriter writeMethod: [ :methodWriter | 
		          writer := methodWriter.
		          aProvenanceEntityRelation to acceptVisitor: self.

		          FylgjaCopy new
			          lookUp: aFylgjaLookUpContext;
			          fylgja: aFylgjaDerivativeModel;
			          provenanceRelation: aProvenanceEntityRelation;
			          cropping: aBlock;
			          applyOn: methodWriter ].

	aDestinationWriter updateBlock: method block with: [ :block | 
		| variable |
		variable := FylgjaAddLocalVariable new
			            name: method selector;
			            typeReference: method returnTypeReference;
			            applyOn: block.
		method block statements last isReturn ifFalse: [ 
			FylgjaAddReturn new
				expression: (self variableReferenceTo: variable using: block);
				applyOn: block ] ].

	^ method
]

{ #category : #printing }
FylgjaTranslateCopyAsMethod >> printOn: aStream [

 	aStream nextPutAll: 'CopyAsMethod'
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitClassFunction: aMOClassFunction [

	mustReturn := true.
	writer setDynamicBinding.
	writer selector: aMOClassFunction selector
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitClassProcedure: aMOClassProcedure [

	writer setDynamicBinding.
	writer selector: aMOClassProcedure selector.
	writer returnTypeReference: (writer typeReferenceNamed: #void)
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitFunction: aMOFunction [
	mustReturn := true.
	writer setStaticBinding.
	writer selector: aMOFunction selector.

]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitProcedure: aMOProcedure [
	
	writer setStaticBinding.
	writer selector: aMOProcedure selector.
	writer returnTypeReference: (writer typeReferenceNamed: #void)
]
