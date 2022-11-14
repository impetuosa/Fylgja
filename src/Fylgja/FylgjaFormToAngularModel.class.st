Class {
	#name : #FylgjaFormToAngularModel,
	#superclass : #FylgjaFormToAngular,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'as yet unclassified' }
FylgjaFormToAngularModel >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| cls |
	aDestinationWriter writeDeclarationUnit: [ :unit | 
		cls := unit writeTypescriptClass: [ :class | 
			       class visibility: #public.
			       class addModifier: #export.
			       class name: (self modelNameFor: aRelatedProvenanceEntity to).

			       aRelatedProvenanceEntity to attributes
				       select: [ :a | 
					       a senders anySatisfy: [ :m | 
						       m parent isSameEntity: aRelatedProvenanceEntity to ] ]
				       thenDo: [ :attr | 
					       FylgjaMigrate new
						       cropping: aBlock;
						       fylgja: aFylgjaDerivativeModel;
						       lookUp: aFylgjaLookUpContext;
						       provenanceEntity: attr;
						       applyOn: class ] ].

		(self importableDependencies: cls) do: [ :type | 
			unit writeImport: [ :import | 
				import importingTypeOrTypeReference: type ] ] ].
	^ cls
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngularModel >> printOn: aStream [
 	aStream nextPutAll: 'Produce Angular Component based on Form usage'
]
