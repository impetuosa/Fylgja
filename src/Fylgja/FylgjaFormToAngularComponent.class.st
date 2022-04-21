Class {
	#name : #FylgjaFormToAngularComponent,
	#superclass : #FylgjaFormToAngular,
	#category : #'Fylgja-Rule-Operations'
}

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
		  writer: aDestinationWriter;
		  modelClassReference: (self
				   resolveModelClassReferenceFor: aRelatedProvenanceEntity
				   using: aDestinationWriter);
		  serviceClassReference: (self
				   resolveServiceClassReferenceFor: aRelatedProvenanceEntity
				   using: aDestinationWriter);
		  export: entity
]
