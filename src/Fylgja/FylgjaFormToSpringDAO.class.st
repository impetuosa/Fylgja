Class {
	#name : #FylgjaFormToSpringDAO,
	#superclass : #FylgjaFormToSpring,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #adding }
FylgjaFormToSpringDAO >> addDeleteModelMethod: class for: aFormOrReport using: aSessionFactoryAttribute [

	^ FylgjaAddHibernateMethodDeleteModel new
		sessionFactory: aSessionFactoryAttribute;
		modelTypeReference:
			(class typeReferenceNamed: (self modelNameFor: aFormOrReport));
		applyOn: class
]

{ #category : #adding }
FylgjaFormToSpringDAO >> addGetAllMethod: class for: aFormOrReport using: aSessionFactoryAttribute [

	^ FylgjaAddHibernateMethodGetAllModel new
		  sessionFactory: aSessionFactoryAttribute;
		  modelTypeReference:
			  (class typeReferenceNamed: (self modelNameFor: aFormOrReport));
		  applyOn: class
]

{ #category : #adding }
FylgjaFormToSpringDAO >> addSaveModelMethod: class for: aFormOrReport using: aSessionFactoryAttribute [

	^ FylgjaAddHibernateMethodSaveModel new
		sessionFactory: aSessionFactoryAttribute;
		modelTypeReference:
			(class typeReferenceNamed: (self modelNameFor: aFormOrReport));
		applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringDAO >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| sessionFactory cls |
	self assert:
		(self
			 hasId: aRelatedProvenanceEntity to
			 using: aFylgjaDerivativeModel) not.
	aDestinationWriter writeDeclarationUnit: [ :unit | 
		cls := unit writeClass: [ :class | 
			       class visibility: #public.
			       class name: (self daoNameFor: aRelatedProvenanceEntity to).
			       self annotateAsRepository: class.
			       sessionFactory := self
				                         addSessionFactoryAttribute: class
				                         for: aRelatedProvenanceEntity to.

			       self
				       addSaveModelMethod: class
				       for: aRelatedProvenanceEntity to
				       using: sessionFactory.
			       self
				       addGetAllMethod: class
				       for: aRelatedProvenanceEntity to
				       using: sessionFactory.
			       self
				       addDeleteModelMethod: class
				       for: aRelatedProvenanceEntity to
				       using: sessionFactory.
			       self
				       updateModelMethod: class
				       for: aRelatedProvenanceEntity to
				       using: sessionFactory ].

		(self importableDependencies: cls) do: [ :type | 
			unit writeImport: [ :import | 
				import importingTypeOrTypeReference: type ] ] ].

	^ cls
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringDAO >> updateModelMethod: class for: aFormOrReport using: aSessionFactoryAttribute [

	^ FylgjaAddHibernateMethodUpdateModel new
		  sessionFactory: aSessionFactoryAttribute;
		  modelTypeReference:
			  (class typeReferenceNamed: (self modelNameFor: aFormOrReport));
		  applyOn: class
]
