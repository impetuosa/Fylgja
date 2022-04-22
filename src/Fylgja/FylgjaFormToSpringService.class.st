Class {
	#name : #FylgjaFormToSpringService,
	#superclass : #FylgjaFormToSpring,
	#category : #'Fylgja-Rule-Operations'
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

	| dao cls |
	^ aDestinationWriter writeDeclarationUnit: [ :unit | 
		  cls := unit writeClass: [ :class | 
			         class visibility: #public.
			         class name:
				         (self serviceNameFor: aRelatedProvenanceEntity to).
			         self annotateAsService: class.
			         self annotateAsTransactional: class.
			         dao := self
				                addDaoDelegate: class
				                for: aRelatedProvenanceEntity to.

			         self
				         addSaveModelMethodService: class
				         for: aRelatedProvenanceEntity to
				         using: dao.
			         self
				         addGetAllMethodService: class
				         for: aRelatedProvenanceEntity to
				         using: dao.
			         self
				         addDeleteModelMethodService: class
				         for: aRelatedProvenanceEntity to
				         using: dao.
			         self
				         updateModelMethodService: class
				         for: aRelatedProvenanceEntity to
				         using: dao ].

		  (self importableDependencies: cls) do: [ :type | 
			  unit writeImport: [ :import | import importType: type ] ] ]
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
