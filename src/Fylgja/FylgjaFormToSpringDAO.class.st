Class {
	#name : #FylgjaFormToSpringDAO,
	#superclass : #FylgjaToSpring,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaFormToSpringDAO >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ aDestinationWriter writeClass: [ :class | 
		  class name: (self daoNameFor: aRelatedProvenanceEntity to).
		  self annotateAsRepository: class.
		  self
			  addSessionFactoryAttribute: class
			  for: aRelatedProvenanceEntity to.
		  self addSaveModelMethod: class for: aRelatedProvenanceEntity to.
		  self addGetAllMethod: class for: aRelatedProvenanceEntity to.
		  self addDeleteModelMethod: class for: aRelatedProvenanceEntity to.
		  self updateStudentMethod: class for: aRelatedProvenanceEntity to ]
]
