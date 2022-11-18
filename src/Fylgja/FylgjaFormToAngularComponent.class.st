Class {
	#name : #FylgjaFormToAngularComponent,
	#superclass : #FylgjaFormToAngular,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'as yet unclassified' }
FylgjaFormToAngularComponent class >> possibleWritingMessages [

	^ { #writeAngularComponent: }
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngularComponent >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| formObject importer pivot entity |
	formObject := (aFylgjaDerivativeModel selectDerivativeModelFor:
		               aRelatedProvenanceEntity to) objects detect: [ :a | 
		              a type name = aRelatedProvenanceEntity to name ].

	importer := CGWidgetImporter new.

	pivot := CSNUICWModel new
		         name: aRelatedProvenanceEntity printString;
		         yourself.
	importer useModel: pivot.

	importer widgetInstance: formObject.
	entity := importer import: aRelatedProvenanceEntity to.


	^ CGWidgetExporter new
		  fylgja: aFylgjaDerivativeModel;
		  croppingWith: aBlock;
		  lookUp: aFylgjaLookUpContext;
		  writer: aDestinationWriter;
		  cssName: (self cssNameFor: aRelatedProvenanceEntity to);
		  templateName: (self templateNameFor: aRelatedProvenanceEntity to);
		  modelClassReference: (self
				   resolveModelClassReferenceFor: aRelatedProvenanceEntity
				   using: aDestinationWriter);
		  serviceClassReference: (self
				   resolveServiceClassReferenceFor: aRelatedProvenanceEntity
				   using: aDestinationWriter);
		  export: entity
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngularComponent >> cssNameFor: aMOAlceForm [

	^ (self modelNameFor: aMOAlceForm) asLowercase
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngularComponent >> printOn: aStream [
 	aStream nextPutAll: 'Produce Angular Component based on Casino for Forms'
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngularComponent >> templateNameFor: aMOAlceForm [

	^ self cssNameFor: aMOAlceForm
]
