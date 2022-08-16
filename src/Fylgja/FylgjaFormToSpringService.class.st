Class {
	#name : #FylgjaFormToSpringService,
	#superclass : #FylgjaFormToSpring,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #adding }
FylgjaFormToSpringService >> addDeleteModelMethodService: class for: aMOAlceForm using: aMOAttribute [

	^ FylgjaAddDelegateAndTransmitParametersMethod new
		  attributeReference:
			  (self variableReferenceTo: aMOAttribute using: class);
		  returnTypeReference: (self booleanTypeReference: class);
		  selector: #delete , (self modelNameFor: aMOAlceForm);
		  parameters: { (#model
			   -> (class typeReferenceNamed: (self modelNameFor: aMOAlceForm))) };
		  applyOn: class
]

{ #category : #adding }
FylgjaFormToSpringService >> addGetAllMethodService: class for: aMOAlceForm using: aMOAttribute [

	^ FylgjaAddDelegateAndTransmitParametersMethod new
		  attributeReference:
			  (self variableReferenceTo: aMOAttribute using: class);
		  returnTypeReference: (self
				   typeReferenceListOf:
					   (class typeReferenceNamed: (self modelNameFor: aMOAlceForm))
				   using: class);
		  selector: #getAll , (self modelNameFor: aMOAlceForm);
		  applyOn: class
]

{ #category : #adding }
FylgjaFormToSpringService >> addSaveModelMethodService: class for: aMOAlceForm using: aMOAttribute [

	^ FylgjaAddDelegateAndTransmitParametersMethod new
		  attributeReference:
			  (self variableReferenceTo: aMOAttribute using: class);
		  returnTypeReference: (self booleanTypeReference: class);
		  selector: #save , (self modelNameFor: aMOAlceForm);
		  parameters: { (#model
			   -> (class typeReferenceNamed: (self modelNameFor: aMOAlceForm))) };
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringService >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	| cls sources |
	sources := self recogniceDataSourceAccesses:
		           aRelatedProvenanceEntity to.
	sources ifEmpty: [ ^ self ].

	aDestinationWriter writeDeclarationUnit: [ :unit | 
		cls := unit writeJavaClass: [ :class | 
			       class visibility: #public.
			       class name:
				       (self serviceNameFor: aRelatedProvenanceEntity to).
			       self annotateAsService: class.
			       self annotateAsTransactional: class.
			       sources do: [ :s | 
				       self generateServiceMethodFor: s into: class using: aFylgja ] ].

		(self importableDependencies: cls) do: [ :type | 
			unit writeImport: [ :import | 
				import importingTypeOrTypeReference: type ] ] ].
	^ cls
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringService >> generateServiceMethodFor: source into: class using: aFylgjaDerivativeModel [

	^ source
		  fylgja: aFylgjaDerivativeModel;
		  applyOnService: class
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringService >> printOn: aStream [
 	aStream nextPutAll: 'Produce Spring Service based on Access Form Usage'
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringService >> updateModelMethodService: class for: aMOAlceForm using: aMOAttribute [

	^ FylgjaAddDelegateAndTransmitParametersMethod new
		  attributeReference:
			  (self variableReferenceTo: aMOAttribute using: class);
		  returnTypeReference: (self booleanTypeReference: class);
		  selector: #update , (self modelNameFor: aMOAlceForm);
		  parameters: { (#model
			   -> (class typeReferenceNamed: (self modelNameFor: aMOAlceForm))) };
		  applyOn: class
]
