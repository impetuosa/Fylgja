Class {
	#name : #FylgjaTranslateCopyAsMethod,
	#superclass : #FylgjaTranslate,
	#instVars : [
		'writer'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ aDestinationWriter writeMethod: [ :methodWriter | 
		  writer := methodWriter.
		  aProvenanceEntityRelation to acceptVisitor: self.
		  methodWriter
			  writeCopyOf: aProvenanceEntityRelation
			  croppingRelationsWith: aBlock
			  readingValues: [ :context :value | 
				  aFylgjaDerivativeModel
					  migrate: value
					  croppingRelationsWith: aBlock
					  intoDestinationWriter: methodWriter
					  lookUp: aFylgjaLookUpContext ]
			  bindingWithCandidates: [ :contextWriter :value | 
				  aFylgjaDerivativeModel
					  bind: value
					  croppingRelationsWith: aBlock
					  intoDestinationWriter: contextWriter
					  lookUp: aFylgjaLookUpContext ] ]
]

{ #category : #printing }
FylgjaTranslateCopyAsMethod >> printOn: aStream [

 	aStream nextPutAll: 'CopyAsMethod'
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitClassFunction: aMOClassFunction [

	writer setDynamicBinding.
	writer selector: aMOClassFunction selector.
	writer returnTypeReference:
		(writer typeReferenceNamed:
			 aMOClassFunction returnTypeReference name)
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitClassProcedure: aMOClassProcedure [

	writer setDynamicBinding.
	writer selector: aMOClassProcedure selector.
	writer returnTypeReference: (writer typeReferenceNamed: #void)
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitFunction: aMOFunction [

	writer setStaticBinding.
	writer selector: aMOFunction selector.
	aMOFunction returnTypeReference ifNotNil: [ 
		writer returnTypeReference:
			(writer typeReferenceNamed: aMOFunction returnTypeReference name) ]
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitProcedure: aMOProcedure [
	
	writer setStaticBinding.
	writer selector: aMOProcedure selector.
	writer returnTypeReference: (writer typeReferenceNamed: #void)
]
