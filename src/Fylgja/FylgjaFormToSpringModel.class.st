Class {
	#name : #FylgjaFormToSpringModel,
	#superclass : #FylgjaFormToSpring,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'as yet unclassified' }
FylgjaFormToSpringModel >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| object tableName cls dataBoundableAttributes model attributes |
"	self assert: aRelatedProvenanceEntity to methods isEmpty."
	model := (aFylgjaDerivativeModel selectDerivativeModelFor:
		          aRelatedProvenanceEntity to) model.
	object := self
		          defaultInstanceFor: aRelatedProvenanceEntity to
		          withIn: model.
	
	tableName := self databaseSourceName: object.


	dataBoundableAttributes := self
		                           allDataBoundableAttributes: object
		                           model: model.

	attributes := self
		              collectAllDatabaseBindings: object
		              marringWith: dataBoundableAttributes.

	self assert:
		(self
			 hasId: aRelatedProvenanceEntity to
			 using: aFylgjaDerivativeModel) not.

	aDestinationWriter writeDeclarationUnit: [ :unit | 
		cls := unit writeJavaClass: [ :class | 
			       class visibility: #public.
			       self annotateAsEntity: class.
			       self annotate: class asTableNamed: tableName.

			       class name: (self modelNameFor: aRelatedProvenanceEntity to).
			       attributes keysAndValuesDo: [ :instance :attr | 
				       | new |
				       new := self
					              addAttribute: attr
					              boundAs: instance
					              croppingRelationsWith: aBlock
					              destinationWriter: class
					              lookUp: aFylgjaLookUpContext
					              using: aFylgjaDerivativeModel.
				       self addSetterAndGetter: new into: class ] ].

		(self importableDependencies: cls) do: [ :type | 
			unit writeImport: [ :import | 
				import importingTypeOrTypeReference: type ] ] ].
	^ cls
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringModel >> printOn: aStream [
 	aStream nextPutAll: 'Produce Model based on Access Form usage '
]
