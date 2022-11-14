Class {
	#name : #FylgjaDBEntityToSpringDAO,
	#superclass : #FylgjaDBEntityToSpring,
	#instVars : [
		'sessionFactory'
	],
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'instance creation' }
FylgjaDBEntityToSpringDAO class >> possibleWritingMessages [

	^ { #writeDeclarationUnit:. #writeClass:. #writeJavaClass: }
]

{ #category : #testing }
FylgjaDBEntityToSpringDAO >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| cls model |
	[ 
	super
		applyTo: aRelatedProvenanceEntity
		croppingRelationsWith: aBlock
		destinationWriter: aDestinationWriter
		lookUp: aFylgjaLookUpContext
		using: aFylgjaDerivativeModel.

	model := (aFylgjaDerivativeModel selectDerivativeModelFor:
		          aRelatedProvenanceEntity to) model.



	aDestinationWriter writeDeclarationUnit: [ :unit | 
		cls := unit writeJavaClass: [ :class | 
			       class visibility: #public.
			       class name: (self daoNameFor: aRelatedProvenanceEntity to).
			       self annotateAsRepository: class.
			       sessionFactory := self
				                         addSessionFactoryAttribute: class
				                         for: aRelatedProvenanceEntity to.

			       destinationWriter := class.
			       aRelatedProvenanceEntity to acceptVisitor: self ].

		(self importableDependencies: cls) do: [ :type | 
			unit writeImport: [ :import | 
				import importingTypeOrTypeReference: type ] ] ].

	^ cls ] ensure: [ 
		block := nil.
		lookUp := nil.
		derivativeModel := nil.
		destinationWriter := nil.
		sessionFactory := nil ]
]

{ #category : #visiting }
FylgjaDBEntityToSpringDAO >> visitQuery: aMOAlceQuery [

	^ self visitTable: aMOAlceQuery
]

{ #category : #testing }
FylgjaDBEntityToSpringDAO >> visitTable: aTable [

	self
		addSaveModelMethod: destinationWriter
		for: aTable
		using: sessionFactory.
	self
		addGetAllMethod: destinationWriter
		for: aTable
		using: sessionFactory.
	self
		addDeleteModelMethod: destinationWriter
		for: aTable
		using: sessionFactory.
	self
		updateModelMethod: destinationWriter
		for: aTable
		using: sessionFactory
]
