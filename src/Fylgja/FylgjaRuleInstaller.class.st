Class {
	#name : #FylgjaRuleInstaller,
	#superclass : #FylgjaMRSInstaller,
	#instVars : [
		'condition',
		'operation'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #accessing }
FylgjaRuleInstaller >> all [

	^ self condition: FylgjaConditionAll new
]

{ #category : #testing }
FylgjaRuleInstaller >> any: aType migratingTo: anOtherType [

	^ self condition: (FylgjaConditionModelTypeIsAndDestinationIs new
			   type: MOAlceForm;
			   destination: anOtherType;
			   yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyAlceDBEntity [

	^ self condition: (FylgjaConditionModelTypeIs new
			   types: { 
					   MOAlceTable.
					   MOAlceQuery };
			   yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyAlceForm [

	^ self condition: (FylgjaConditionModelTypeIs new
			   type: MOAlceForm;
			   yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyAlceModule [

	^ self condition: (FylgjaConditionModelTypeIs new
			   type: MOModule;
			   yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyBindableEntity [
	^ self condition: (FylgjaConditionReferenceWithoutCandidate new)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyClassNamed: aNames [
  ^self condition: (FylgjaConditionModelTypeIsAndNamed new
           types: {MOStClass . 
              MOClass . 
              MOClassType . 
              MOMetaClass};
           names: aNames;
           yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyEntity [

	<doc: 'Condition:
1. Allways true'>

	^ self condition: FylgjaConditionAll new
]

{ #category : #testing }
FylgjaRuleInstaller >> anyEntityOfType: aType [ 

	^ self condition: (FylgjaConditionModelTypeIs new
			   type: aType;
			   yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyInvocation [

	^ self condition: (FylgjaConditionModelTypeIs new
			   type: MOInvocation;
			   yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyInvocationTo: aString [

	^ self condition: (FylgjaConditionInvocationSelectorIs new
			   selector: aString;
			   yourself) increasePriority
]

{ #category : #testing }
FylgjaRuleInstaller >> anyJavaMethodAnnotatedWith: javaAnnotationNames transferredToTypescriptDecoratedWith: typescriptDecoratorNames [

	^ self condition: ((FylgjaConditionAnyJavaMethodAnnotated new
			    annotationNames: javaAnnotationNames;
			    yourself) and: (FylgjaConditionAnyTypescriptClassDecorated new
				    decoratorNames: typescriptDecoratorNames;
				    yourself))
]

{ #category : #testing }
FylgjaRuleInstaller >> anyKindOfClass [

	^ self condition:
		  (FylgjaConditionModelTypeIsKindOf new type: MOClass)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyMetaclassMethodNamed: aString [
  self condition: (FylgjaIsMethodNamedInMetaclass new
           names: {aString};
           yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyMethodNamed: aCollection [
  ^self condition: (FylgjaConditionAnyMethodNamed new
           names: aCollection;
           yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyModelEntityOfTypesWhenGoingClass: aCollection [
<doc: 'Condition:
1. The source entity is any in the given collection AND
2. The target context is a class'>
	^ self condition: (FylgjaConditionModelTypeIsAndContextIs new
			   types: aCollection;
			   contextType: MOClass;
			   yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyOnErrorGoToBlockTransformableToTryCatch [

	^ self condition: FylgjaConditionOnErrorGoToBlockTransformableToTryCatch new
]

{ #category : #testing }
FylgjaRuleInstaller >> anyPragmaWithSelector: aString [
  ^self condition: (FylgjaConditionIsPragmaWithSelector new
           selector: aString;
           yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyPrimitiveTypeReference [

	^ self condition: FylgjaConditionPrimitiveTypeReference new
]

{ #category : #testing }
FylgjaRuleInstaller >> anyReferenceWithCandidate [

	^ self condition: FylgjaConditionReferenceWithCandidate new
]

{ #category : #testing }
FylgjaRuleInstaller >> anyReturnInvocationTo: aString [

	^ self condition: (FylgjaConditionInvocationSelectorIsInReturn new
			   selector: aString;
			   yourself) increasePriority
]

{ #category : #testing }
FylgjaRuleInstaller >> anySpringBootControllerClass [

	^ self condition: FylgjaConditionAnySpringBootControllerClass new
]

{ #category : #testing }
FylgjaRuleInstaller >> anyStructure [

	^ self condition: (FylgjaConditionModelTypeIs new
			   type: MOStructure;
			   yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> anyTypeReferenceNamed: aString [

	^ self condition: (FylgjaConditionTypeReferenceIs new
			   typeName: aString;
			   yourself)
]

{ #category : #copying }
FylgjaRuleInstaller >> applyAllOperations: aFullBlockClosure [

	| operations |
	operations := aFullBlockClosure value: self.
	^ self operation: (FylgjaOperationMultipleProductions new
			   operations: operations;
			   yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> binaryOperator: aString [
<doc: 'Condition:
1. The source entity is a binary operation
2. The operator matches the parameter.'>
	^ self condition: (FylgjaConditionBinaryExpression new
			   operator: aString;
			   yourself)
]

{ #category : #copying }
FylgjaRuleInstaller >> bindRewriteTo: aDestinationEntity [

	^ self operation: (FylgjaBindRewrite new
			   destinationEntity: aDestinationEntity;
			   yourself)
]

{ #category : #accessing }
FylgjaRuleInstaller >> build [
	^ (operation isAdapting
		   ifTrue: [ FylgjaDynamicAdaptingRule new ]
		   ifFalse: [ FylgjaDynamicProductionRule new ])
		  condition: condition;
		  operation: operation;
		  yourself
]

{ #category : #accessing }
FylgjaRuleInstaller >> comment [
	self operation: FylgjaTranslateCopyAsComment new .
]

{ #category : #accessing }
FylgjaRuleInstaller >> condition: aCondition [

	condition := aCondition.
	^ condition
]

{ #category : #accessing }
FylgjaRuleInstaller >> copy [

	<doc: '
Operation:
1. Make an instance of the same class as the source entity within the target context.
2. Migrate each of the children of the source entity using the freshly created instance as the target context.'>


	self operation: FylgjaTranslateCopy new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsAttribute [

	self operation: FylgjaTranslateCopyAsAttribute new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsMethod [

	<doc: 'Operation:
1. Define in the target entity a static method with the same selector as the source entity and using void as returning type reference.
2. Migrate all the children of the source entity using the method as the target context.'>
	self operation: FylgjaTranslateCopyAsMethod new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsPublicClass [

	^ self operation: FylgjaTranslateCopyAsClass new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsPublicTypescriptClass [

	^ self operation: FylgjaTranslateCopyAsTypescriptClass new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsSelfFFiInvocation [
	^ self operation: FylgjaTranslateCopyAsSelfFFICall new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsSpringBootControllerMethod [

	self operation: FylgjaTranslateCopyAsAnnotatedMethod new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsStMethod [

	self operation: FylgjaTranslateCopyAsStMethod new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsStPublicClass [

	^ self operation: FylgjaTranslateCopyAsStClass new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsTypesReferenceNamed: aString [

	^ self operation: (FylgjaTranslateCopyRenameTypeReference new
			   name: aString;
			   yourself)
]

{ #category : #copying }
FylgjaRuleInstaller >> copyRecategorizeMethods [
	self operation: FylgjaTranslateCopyRecategorizeExtensionMethods new 
]

{ #category : #copying }
FylgjaRuleInstaller >> copyRename: aString [
  self operation: (FylgjaCopyRename new
           name: aString;
           yourself)
]

{ #category : #copying }
FylgjaRuleInstaller >> copyRenameMethod: aString [
  self operation: (FylgjaCopyRenameSelector new
           name: aString;
           yourself)
]

{ #category : #copying }
FylgjaRuleInstaller >> copyReplaceCategoryWithDestinationPackage [
	^ self operation: FylgjaTranslateCopyReplaceCategory new 
]

{ #category : #copying }
FylgjaRuleInstaller >> dbEntityToAngularModel [

	^ self operation: FylgjaDBEntityToAngularModel new
]

{ #category : #copying }
FylgjaRuleInstaller >> dbEntityToSpringDAO [

	^ self operation: FylgjaDBEntityToSpringDAO new
]

{ #category : #copying }
FylgjaRuleInstaller >> dbEntityToSpringModel [

	^ self operation: FylgjaDBEntityToSpringModel new
]

{ #category : #copying }
FylgjaRuleInstaller >> dispatchToSubPackages: aCollection [

	^ self operation: (FylgjaOperationMultiDispatch new
			   destinations: aCollection;
			   yourself)
]

{ #category : #copying }
FylgjaRuleInstaller >> formToAngularComponent [

	^ self operation: FylgjaFormToAngularComponent new
]

{ #category : #copying }
FylgjaRuleInstaller >> formToAngularModel [

	^ self operation: FylgjaFormToAngularModel new
]

{ #category : #copying }
FylgjaRuleInstaller >> formToAngularService [ 

	^ self operation: FylgjaFormToAngularService new
]

{ #category : #copying }
FylgjaRuleInstaller >> formToSpringController: anUrl apiURLExtention: aString [

	^ self operation: (FylgjaFormToSpringController new
			   originURL: anUrl;
			   apiURLExtention: aString;
			   yourself)
]

{ #category : #copying }
FylgjaRuleInstaller >> formToSpringDAO [

	^ self operation: FylgjaFormToSpringDAO new
]

{ #category : #copying }
FylgjaRuleInstaller >> formToSpringModel [

	^ self operation: FylgjaFormToSpringModel new
]

{ #category : #copying }
FylgjaRuleInstaller >> formToSpringService [

	^ self operation: FylgjaFormToSpringService new
]

{ #category : #accessing }
FylgjaRuleInstaller >> install: rule into: aFylgja [

	| space |
	space := self installingSpace: aFylgja.
	rule isAdaptingRule
		ifTrue: [ space installAdaptingRule: rule ]
		ifFalse: [ space installProducingRule: rule ]
]

{ #category : #accessing }
FylgjaRuleInstaller >> installInto: aFylgja [

	| rule |
	rule := self build.
	self assert: rule condition isNotNil.
	self assert: rule operation isNotNil.
	^ self install: rule into: aFylgja
]

{ #category : #copying }
FylgjaRuleInstaller >> invocationToMessageSend [

	self operation: FylgjaTranslateInvocationToMessageSend new.
	^ self operation
]

{ #category : #copying }
FylgjaRuleInstaller >> invocationToMessageSendToSelf [
	self invocationToMessageSend receiverBlock: [ :writer | 
		writer referenceToSelf ]
]

{ #category : #testing }
FylgjaRuleInstaller >> isNotPreexistingClass [
  ^self condition: FylgjaIsNotPreexistingClass new
]

{ #category : #testing }
FylgjaRuleInstaller >> isPreexistingClass [
  ^self condition: FylgjaIsPreexistingClass new
]

{ #category : #copying }
FylgjaRuleInstaller >> mappingLinkedStubInstall [

	self operation: FylgjaBindToLinkedStub new
]

{ #category : #testing }
FylgjaRuleInstaller >> matchesPattern: aFylgjaPattern [

	self condition: aFylgjaPattern
]

{ #category : #copying }
FylgjaRuleInstaller >> migrateAsURLCall [

	^ self operation: FylgjaFromJavaControllerToAngularService new
]

{ #category : #copying }
FylgjaRuleInstaller >> modifyExtendedClassOrCreateStubClass [
	^ self operation: FylgjaTranslateModifyExistingOrCreateStub new 
]

{ #category : #copying }
FylgjaRuleInstaller >> onErrorGoToToTryCatch [

	^ self operation: FylgjaCopyReplaceErrorGoToToTryCatch new 
]

{ #category : #accessing }
FylgjaRuleInstaller >> operation [
	^ operation
]

{ #category : #accessing }
FylgjaRuleInstaller >> operation: anOperation [

	operation := anOperation.
	^ operation
]

{ #category : #testing }
FylgjaRuleInstaller >> prefixUnaryOperator: aString [

	^ self condition: (FylgjaConditionUnaryOperator new
			   operator: aString;
			   setAsPrefix;
			   yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> referenceNamed: aString [

	^ self condition: (FylgjaConditionReferenceNamed new
			   name: aString;
			   yourself)
]

{ #category : #copying }
FylgjaRuleInstaller >> replaceOperatorWith: aString [

	<doc:
'1. Define a binary operation in the target entity, using the parameter as an operator.
2. Migrate all the children of the source entity using the binary operation as the target context.'>
	^ self operation: (FylgjaCopyReplaceBinaryOperator new
			   operator: aString;
			   yourself)
]

{ #category : #copying }
FylgjaRuleInstaller >> replacePostfixUnaryOperatorWith: aString [

	^ self operation: (FylgjaCopyReplaceUnaryOperator new
			   operator: aString;
			   setAsPostfix;
			   yourself)
]

{ #category : #copying }
FylgjaRuleInstaller >> replacePrefixUnaryOperatorWith: aString [

	^ self operation: (FylgjaCopyReplaceUnaryOperator new
			   operator: aString;
			   setAsPrefix;
			   yourself)
]

{ #category : #copying }
FylgjaRuleInstaller >> replaceSufixUnaryOperatorWith: aString [

	^ self operation: (FylgjaCopyReplaceUnaryOperator new
			   operator: aString;
			   setAsSufix;
			   yourself)
]

{ #category : #copying }
FylgjaRuleInstaller >> replaceWithStringLiteral: aString [

	^ self operation: (FylgjaTranslateReplaceWithStringLiteral new
			   string: aString;
			   yourself)
]

{ #category : #copying }
FylgjaRuleInstaller >> returnSameBinding [

	^ self operation: FylgjaBindToSameBinding new
]

{ #category : #copying }
FylgjaRuleInstaller >> rewriteAsTypeReference [

	^ self operation: FylgjaCopyReplaceTypeReference new
]

{ #category : #testing }
FylgjaRuleInstaller >> whenIsReferenceWithCandidate: aProvenanceCandidate [

	^ self condition: (FylgjaConditionReferenceCandidateIs new
			   referee: aProvenanceCandidate;
			   yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> whenIsReferenceWithCandidates:  someProvenanceCandidates [

	^ self condition: (FylgjaConditionReferenceCandidateIsAny new
			   candidates: someProvenanceCandidates;
			   yourself)
]

{ #category : #testing }
FylgjaRuleInstaller >> whenTypeOfModelEntityIs: aClass [

	^ self condition: (FylgjaConditionModelTypeIsKindOf new type: aClass)
]
