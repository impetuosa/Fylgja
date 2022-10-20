Class {
	#name : #FylgjaTranslateCopyAsMethod,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'writer',
		'mustReturn',
		'lookUp',
		'fylgja',
		'provenance',
		'cropping',
		'translatingIntoTestCase'
	],
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod class >> possibleWritingMessages [

	^ { #writeMethod: }
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| method shouldAddFunctionVariable |
	[ 
	mustReturn := false.
	lookUp := aFylgjaLookUpContext.
	fylgja := aFylgjaDerivativeModel.
	provenance := aProvenanceEntityRelation.
	cropping := aBlock.
	shouldAddFunctionVariable := true.
	translatingIntoTestCase := false. 
	aDestinationWriter superclassReference ifNotNil: [ 
		translatingIntoTestCase := aDestinationWriter superclassReference
			                           name = #TestCase ].
	method := aDestinationWriter writeMethod: [ :methodWriter | 
		          writer := methodWriter.
		          aProvenanceEntityRelation to acceptVisitor: self.
		          methodWriter returnTypeReference ifNil: [ 
			          (self containsSetToReturnStatament:
				           aProvenanceEntityRelation to block) ifFalse: [ 
				          shouldAddFunctionVariable := false.
				          writer returnTypeReference:
					          (writer typeReferenceNamed: #void) ] ] ].
	({ 
		 MOClassProcedure.
		 MOProcedure } anySatisfy: [ :c | 
		 aProvenanceEntityRelation to species = c ]) ifTrue: [ ^ self ].
	method block isEmptyOrNil ifFalse: [ 
		shouldAddFunctionVariable ifTrue: [ 
			aDestinationWriter updateBlock: method block with: [ :block | 
				| variable |
				variable := FylgjaAddLocalVariable new
					            name: method selector;
					            typeReference: method returnTypeReference;
					            applyOn: block.
				method block statements last isReturn ifFalse: [ 
					FylgjaAddReturn new
						expression: (self variableReferenceTo: variable using: block);
						applyOn: block ] ] ] ] ] ensure: [ 
		lookUp := nil.
		fylgja := nil.
		provenance := nil.
		cropping := nil.
		writer := nil ].
	^ method
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isInvocable and: [ 
		  (aProvenanceEntityRelation to isFunction or: [ 
			   aProvenanceEntityRelation to isProcedure ]) and: [ 
			  self canWriteOver: aWriter ] ]
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> containsSetToReturnStatament: aBlock [

	^ FylgjaSearch new
		  anySatisfy: [ :node | 
			  (node isKindOf: MOAssignment) ifTrue: [ self halt ].
			  false ]
		  within: aBlock
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> copyFullBody [

	FylgjaCopy new
		lookUp: lookUp;
		fylgja: fylgja;
		provenanceRelation: provenance;
		cropping: cropping;
		applyOn: writer
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> printOn: aStream [
 	aStream nextPutAll: 'Transform into Method'
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitClassFunction: aMOClassFunction [

	mustReturn := true.
	writer setDynamicBinding.
	writer selector: aMOClassFunction selector.
	self copyFullBody.
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitClassProcedure: aMOClassProcedure [

	writer setDynamicBinding.
	writer selector: aMOClassProcedure selector.
	writer returnTypeReference: (writer typeReferenceNamed: #void).
	self copyFullBody
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitFunction: aMOFunction [
	| before| 
	mustReturn := true.
	before := writer. 
	writer selector: aMOFunction selector.
	self copyFullBody.
	writer := before. 
	translatingIntoTestCase
		ifTrue: [ writer setDynamicBinding ]
		ifFalse: [ writer setStaticBinding ].
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitProcedure: aMOProcedure [

	writer selector: aMOProcedure selector.
	writer returnTypeReference: (writer typeReferenceNamed: #void).
	self copyFullBody.
	translatingIntoTestCase
		ifTrue: [ writer setDynamicBinding ]
		ifFalse: [ writer setStaticBinding ]
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitVariableAccessor: aMOVariableAccessor [

	writer setStaticBinding.
	writer selector: aMOVariableAccessor kind asLowercase
		, aMOVariableAccessor selector capitalized.

	aMOVariableAccessor kind = #Get
		ifTrue: [ mustReturn := true ]
		ifFalse: [ 
		writer returnTypeReference: (writer typeReferenceNamed: #void) ].

	FylgjaCopy new
		lookUp: lookUp;
		fylgja: fylgja;
		provenanceRelation: provenance;
		cropping: [ :col | 
			(cropping value: col) select: [ :relation | 
					(relation name = #kind) not ] ];
		applyOn: writer
]
