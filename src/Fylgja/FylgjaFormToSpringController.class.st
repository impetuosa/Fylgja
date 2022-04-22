Class {
	#name : #FylgjaFormToSpringController,
	#superclass : #FylgjaFormToSpring,
	#instVars : [
		'originURL',
		'apiURLExtention'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #adding }
FylgjaFormToSpringController >> addGetAllMethodController: class for: aMOAlceForm using: aMOAttribute [

	^ FylgjaAddAnnotatedDelegateMethod new
		  addAnnotationProduction: (self annotatingAsGetMapping:
					   (self modelNameFor: aMOAlceForm) , '-list');
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
FylgjaFormToSpringController >> addSaveModelMethodController: aMOClassWriter for: aMOAlceForm using: aMOAttribute [ 
	self halt .
]

{ #category : #accessing }
FylgjaFormToSpringController >> apiURLExtention [
	^ apiURLExtention
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringController >> apiURLExtention: aString [

	apiURLExtention := aString
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringController >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	| dao cls |
	^ aDestinationWriter writeDeclarationUnit: [ :unit | 
		  cls := unit writeClass: [ :class | 
			         class visibility: #public.
			         class name:
				         (self controllerNameFor: aRelatedProvenanceEntity to).
			         self annotateAsRestController: class.
			         self
				         annotateAsCrossOrigin: class
				         withOriginAt: self originURL.
			         self
				         annotateAsRequestMapping: class
				         mappingTo: self apiURLExtention.


			         dao := self
				                addServiceDelegate: class
				                for: aRelatedProvenanceEntity to.

			         (self hasId: aRelatedProvenanceEntity to using: aFylgja) 
				         ifTrue: [ 
					         self
						         addSaveModelMethodController: class
						         for: aRelatedProvenanceEntity to
						         using: dao.

					         self
						         addDeleteModelMethodController: class
						         for: aRelatedProvenanceEntity to
						         using: dao.
					         self
						         updateModelMethodController: class
						         for: aRelatedProvenanceEntity to
						         using: dao ].
			         self
				         addGetAllMethodController: class
				         for: aRelatedProvenanceEntity to
				         using: dao ].

		  (self importableDependencies: cls) do: [ :type | 
			  unit writeImport: [ :import | import importType: type ] ] ]
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringController >> originURL [
	 ^ originURL 
]

{ #category : #accessing }
FylgjaFormToSpringController >> originURL: aString [ 
	originURL := aString
]
