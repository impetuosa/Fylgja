Class {
	#name : #FylgjaMigrateDeclarationIntoClassPreMappingTests,
	#superclass : #NotThatGoodTests,
	#category : #'Fylgja-Test'
}

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassPreMappingTests >> allReferencesFrom: aFylgjaDerivationResult [

	^ aFylgjaDerivationResult derivative derivativeModels second entities 
		  select: [ :a | a isReference and: [ a respondsTo: #candidate ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassPreMappingTests >> installRulesFor: destinationClass [

	" By default in the system we copy"

	FylgjaRuleInstaller new
		topLevel;
		anyBindableEntity;
		mappingLinkedStubInstall;
		installInto: fylgja.

	FylgjaRuleInstaller new
		topLevel;
		anyReferenceWithCandidate;
		returnSameBinding;
		installInto: fylgja.



	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.
	" By default when going to java "

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destinationClass);
		anyModelEntityOfTypesWhenGoingClass: { 
				MOClassFunction.
				MOClassProcedure.
				MOFunction.
				MOProcedure };
		copyAsMethod;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destinationClass);
		anyTypeReferenceNamed: #Boolean;
		copyAsTypesReferenceNamed: #bool;
		installInto: fylgja
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassPreMappingTests >> testProduceMethodIntoClassByCopyNodeTransformAddRuleToMapBooleanToBool [

	| function destinationClass result |
	function := self logErrorFunction.
	destinationClass := self configClassConfigPackage.


	self installRulesFor: destinationClass.

	result := fylgja produce: function into: destinationClass.
	self assertAllReferencesHaveCandidate: result.


]
