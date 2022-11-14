Class {
	#name : #FylgjaFormToSpringController,
	#superclass : #FylgjaFormToSpring,
	#instVars : [
		'originURL',
		'apiURLExtention'
	],
	#category : #'Fylgja-Rule-Generation'
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

	| service cls sources |
	sources := self recogniceDataSourceAccesses:
		           aRelatedProvenanceEntity to.

	aDestinationWriter writeDeclarationUnit: [ :unit | 
		cls := unit writeJavaClass: [ :class | 
			       class visibility: #public.
			       class name:
				       (self controllerNameFor: aRelatedProvenanceEntity to).
			       self annotateAsRestController: class.
			       self
				       annotateAsCrossOrigin: class
				       withOriginAt: self originURL.
			       self
				       annotateAsRequestMapping: class
				       mappingTo: self apiURLExtention , '/'
					       , (self controllerNameFor: aRelatedProvenanceEntity to).

			       service := self
				                  addServiceDelegate: class
				                  for: aRelatedProvenanceEntity to.

			       sources do: [ :s | 
				       s
					       service: service;
					       applyOnController: class ] ].

		(self importableDependencies: cls) do: [ :type | 
			unit writeImport: [ :import | 
				import importingTypeOrTypeReference: type ] ] ].
	^ cls
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringController >> originURL [
	 ^ originURL 
]

{ #category : #accessing }
FylgjaFormToSpringController >> originURL: aString [ 
	originURL := aString
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringController >> printOn: aStream [
 	aStream nextPutAll: 'Produce Spring Controller based on Access Form Usage'
]
