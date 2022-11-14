Class {
	#name : #FylgjaFormToSpringDAO,
	#superclass : #FylgjaFormToSpring,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'as yet unclassified' }
FylgjaFormToSpringDAO >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| sessionFactory ret cls model sources  elementRelation classifiedSources |
	model := (aFylgjaDerivativeModel selectDerivativeModelFor:
		          aRelatedProvenanceEntity to) model.


	sources := self recogniceDataSourceAccesses:
		           aRelatedProvenanceEntity to.
	sources ifEmpty: [ ^ self ].
	classifiedSources := sources groupedBy: [ :a | 
		                     [ a resolveUsedDAOUsing: aDestinationWriter ]
			                     on: Error
			                     do: [ nil ] ].


	classifiedSources keysAndValuesDo: [ :classOrNil :src | 
		classOrNil ifNotNil: [ 
			elementRelation := aFylgjaDerivativeModel 
				                   readEntitysContextualizingRelation: classOrNil.

			aDestinationWriter model writer
				updaterFor: elementRelation
				with: elementRelation
				do: [ :elem :destinationWriter | 
					src do: [ :srcEntity | srcEntity applyOnDao: destinationWriter ] ] ] ].
	ret := classifiedSources keys reject: #isNil.

	(classifiedSources includesKey: nil) ifTrue: [ 
		aDestinationWriter writeDeclarationUnit: [ :unit | 
			cls := unit writeJavaClass: [ :class | 
				       class visibility: #public.
				       class name: (self daoNameFor: aRelatedProvenanceEntity to).
				       self annotateAsRepository: class.
				       sessionFactory := self
					                         addSessionFactoryAttribute: class
					                         for: aRelatedProvenanceEntity to.
				       (classifiedSources at: nil) do: [ :s | 
					       self
						       generateDAOMethodFor: s
						       using: sessionFactory
						       into: class ] ].

			(self importableDependencies: cls) do: [ :type | 
				unit writeImport: [ :import | 
					import importingTypeOrTypeReference: type ] ] ].
		ret add: cls ].
	^ ret
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringDAO >> generateDAOMethodFor: aFylgjaSQLSourceToDAOMethod using: aSessionFactory into: aMOClassWriter [

	^ aFylgjaSQLSourceToDAOMethod
		  sessionFactory: aSessionFactory;
		  applyOnDao: aMOClassWriter
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpringDAO >> printOn: aStream [
 	aStream nextPutAll: 'Produce Spring DAO based on Access Form Usage'
]
