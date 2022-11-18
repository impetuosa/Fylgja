Class {
	#name : #FylgjaDBEntityToAngularModel,
	#superclass : #FylgjaAccessToAngular,
	#instVars : [
		'block',
		'destinationWriter',
		'lookUp',
		'derivativeModel'
	],
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'instance creation' }
FylgjaDBEntityToAngularModel class >> possibleWritingMessages [

	^ { #writeDeclarationUnit: }
]

{ #category : #testing }
FylgjaDBEntityToAngularModel >> addAttribute: attr croppingRelationsWith: aBlock destinationWriter: class lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| typeReference operation |
	typeReference := FylgjaMigrate new
		                 cropping: aBlock;
		                 fylgja: aFylgjaDerivativeModel;
		                 lookUp: aFylgjaLookUpContext;
		                 provenanceEntity: attr typeReference;
		                 applyOn: class.

	operation := FylgjaAddAttribute new
		             visibility: #public;
		             name: attr sanitizedName;
		             typeReference: typeReference.

	^ operation applyOn: class
]

{ #category : #testing }
FylgjaDBEntityToAngularModel >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| cls model attributes |
	[ 
	block := aBlock.
	lookUp := aFylgjaLookUpContext.
	derivativeModel := aFylgjaDerivativeModel.
	destinationWriter := aDestinationWriter.

	model := (aFylgjaDerivativeModel selectDerivativeModelFor:
		          aRelatedProvenanceEntity to) model.


	attributes := aRelatedProvenanceEntity to attributes.

	aDestinationWriter writeDeclarationUnit: [ :unit | 
		cls := unit writeTypescriptClass: [ :class | 
			       class visibility: #public.

			       class name: (self modelNameFor: aRelatedProvenanceEntity to).
			       destinationWriter := class.
			       aRelatedProvenanceEntity to acceptVisitor: self ].

		(self importableDependencies: cls) do: [ :type | 
			unit writeImport: [ :import | 
				import importingTypeOrTypeReference: type ] ] ] ] ensure: [ 
		block := nil.
		lookUp := nil.
		derivativeModel := nil.
		destinationWriter := nil ].
	^ cls
]

{ #category : #testing }
FylgjaDBEntityToAngularModel >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isDatasource and: [ 
		  self canWriteOver: aWriter ]
]

{ #category : #testing }
FylgjaDBEntityToAngularModel >> visitQuery: aTable [

	aTable attributes do: [ :attr | 
		| new |
		new := self
			       addAttribute: attr
			       croppingRelationsWith: block
			       destinationWriter: destinationWriter
			       lookUp: lookUp
			       using: derivativeModel.]
]

{ #category : #testing }
FylgjaDBEntityToAngularModel >> visitTable: aTable [

	aTable attributes do: [ :attr | 
		| new |
		new := self
			       addAttribute: attr
			       croppingRelationsWith: block
			       destinationWriter: destinationWriter
			       lookUp: lookUp
			       using: derivativeModel. ]
]
