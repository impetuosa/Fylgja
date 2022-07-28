Class {
	#name : #FylgjaMigrateDeclarationIntoClassMappingTests,
	#superclass : #NotThatGoodTests,
	#category : #'Fylgja-Test'
}

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassMappingTests >> accessBoolean [

	^ northwind entities detect: [ :e | 
		  e isType and: [ 
			  e name asLowercase = #boolean and: [ 
				  e parent isKindOf: MOLibrary ] ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassMappingTests >> accessVariant [

	^ northwind entities detect: [ :e | 
		  e isType and: [ 
			  e name asLowercase = #variant and: [ 
				  e parent isKindOf: MOLibrary ] ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassMappingTests >> installRulesFor: destinationClass [

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

	
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassMappingTests >> javaBoolean [

	^ java entities detect: [ :e | e isType and: [ e name = #Boolean ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassMappingTests >> javaObject [

	^ java entities detect: [ :e | e isType and: [ e name = #Object ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassMappingTests >> testProduceMethodIntoClassByCopyNodeTransformAddRuleToMapBooleanToBooleanClass [

	| function destinationClass result |
	function := self logErrorFunction.
	destinationClass := self configClassConfigPackage.

	self installRulesFor: destinationClass.

	result := fylgja map: self accessBoolean to: self javaBoolean.
	result := result produce: function into: destinationClass.
	self assert: destinationClass methods size equals: 4.
	self assert: result result isKindOf: MOMethod.

	self assert: result result returnTypeReference name equals: #Boolean.
	self assert: result result returnTypeReference candidate isNotNil.
	self
		assert: result result returnTypeReference candidate
		isKindOf: MOClass
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassMappingTests >> testProduceMethodIntoClassByCopyNodeTransformAddRuleToMapVariantUsesToObjectDefault [

	| function destinationClass result modifiedClass |
	function := self logErrorFunction.
	destinationClass := self configClassConfigPackage.
	self installRulesFor: destinationClass.


	result := fylgja map: self accessVariant to: self javaObject.
	result := result produce: function into: destinationClass.
	self assert: result result isKindOf: MOMethod.
self assert: destinationClass methods size equals: 4.

	self
		assert: result result parameters first typeReference name
		equals: function parameters first typeReference name.
	self assert: result result parameters first isKindOf: MOParameter.
	self assert: result result parameters first language isJava.
	self assert:
		result result parameters first typeReference language isJava.


	" Second parameter "

	self
		assert: result result parameters second name
		equals: function parameters second name.

	" The second parameter does not have type specification. So it becomes Variant "
	self
		assert: result result parameters second typeReference name
		equals: #Object.


	self
		assert: result result returnTypeReference name
		equals: function returnTypeReference name
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassMappingTests >> testProduceMethodIntoClassByCopyNodeTransformAvoidRuleToMapBooleanToBooleanPrimitive [

	| function destinationClass result modifiedClass |
	function := self logErrorFunction.
	destinationClass := self configClassConfigPackage.

	self installRulesFor: destinationClass.

	result := fylgja produce: function into: destinationClass.

	self assert: result result isKindOf: MOMethod.

	self assert: result result returnTypeReference name equals: #Boolean.
	self assert: result result returnTypeReference candidate isNotNil.
	self
		assert: result result returnTypeReference candidate
		isKindOf: MOPrimitiveType
]
