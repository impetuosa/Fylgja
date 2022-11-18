Class {
	#name : #FylgjaDBEntityToSpringModel,
	#superclass : #FylgjaDBEntityToSpring,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'instance creation' }
FylgjaDBEntityToSpringModel class >> possibleWritingMessages [

	^ { #writeDeclarationUnit:. #writeClass:. #writeJavaClass: }
]

{ #category : #testing }
FylgjaDBEntityToSpringModel >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| cls model attributes |
	[ 
	super
		applyTo: aRelatedProvenanceEntity
		croppingRelationsWith: aBlock
		destinationWriter: aDestinationWriter
		lookUp: aFylgjaLookUpContext
		using: aFylgjaDerivativeModel.

	model := (aFylgjaDerivativeModel selectDerivativeModelFor:
		          aRelatedProvenanceEntity to) model.


	attributes := aRelatedProvenanceEntity to attributes.

	aDestinationWriter writeDeclarationUnit: [ :unit | 
		cls := unit writeJavaClass: [ :class | 
			       class visibility: #public.
			       self annotateAsEntity: class.
			       self
				       annotate: class
				       asTableNamed: aRelatedProvenanceEntity to name.
			       class name: (self modelNameFor: aRelatedProvenanceEntity to).
			       destinationWriter := class.
			       aRelatedProvenanceEntity to acceptVisitor: self ].

		(self importableDependencies: cls) do: [ :type | 
			unit writeImport: [ :import | 
				import importingTypeOrTypeReference: type ] ] ].
	^ cls ] ensure: [ 
		block := nil.
		lookUp := nil.
		derivativeModel := nil.
		destinationWriter := nil ]
]

{ #category : #testing }
FylgjaDBEntityToSpringModel >> visitQuery: aTable [

	aTable attributes do: [ :attr | 
		| new |
		new := self
			       addAttribute: attr
			       annotatedAsColumnNamed: attr name
			       croppingRelationsWith: block
			       destinationWriter: destinationWriter
			       lookUp: lookUp
			       using: derivativeModel.
		self addSetterAndGetter: new into: destinationWriter ]
]

{ #category : #testing }
FylgjaDBEntityToSpringModel >> visitTable: aTable [

	aTable attributes do: [ :attr | 
		| new |
		new := self
			       addAttribute: attr
			       annotatedAsColumnNamed: attr name
			       croppingRelationsWith: block
			       destinationWriter: destinationWriter
			       lookUp: lookUp
			       using: derivativeModel.
		self addSetterAndGetter: new into: destinationWriter ]
]
