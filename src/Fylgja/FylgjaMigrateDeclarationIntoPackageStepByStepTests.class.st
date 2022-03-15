Class {
	#name : #FylgjaMigrateDeclarationIntoPackageStepByStepTests,
	#superclass : #NotThatGoodTests,
	#category : #'Fylgja-Test'
}

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageStepByStepTests >> installRulesFor: destination [

	| vbCrlf installer |
	vbCrlf := self vbCrlf.

	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		mappingStubInstall;
		installInto: fylgja.
	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		prefixUnaryOperator: #Not;
		replacePrefixUnaryOperatorWith: #!;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		binaryOperator: #Is;
		replaceOperatorWith: #==;
		installInto: fylgja.


	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		binaryOperator: #And;
		replaceOperatorWith: #&&;
		installInto: fylgja.


	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		binaryOperator: #Or;
		replaceOperatorWith: #'||';
		installInto: fylgja.



	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		binaryOperator: #=;
		replaceOperatorWith: #==;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		binaryOperator: #&;
		replaceOperatorWith: #+;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		binaryOperator: #<>;
		replaceOperatorWith: #!=;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		referenceNamed: 'vbCrLf';
		replaceWithStringLiteral: '\r\n';
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		anyTypeReferenceNamed: #Boolean;
		copyAsTypesReferenceNamed: #bool;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		anyAlceModule;
		copyAsPublicClass;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		anyOnErrorGoToBlockTransformableToTryCatch;
		onErrorGoToToTryCatch;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		anyTypeReferenceNamed: #Variant;
		copyAsTypesReferenceNamed: #Object;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		anyTypeReferenceNamed: '#_TypeUndefined';
		copyAsTypesReferenceNamed: #Object;
		installInto: fylgja.




	FylgjaRuleInstaller new
		atLanguageNamed: #java;
		anyInvocation;
		invocationToMessageSendToSelf;
		installInto: fylgja.

	" By default when going to java "
	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		anyModelEntityOfTypesWhenGoingClass: { 
				MOClassFunction.
				MOClassProcedure.
				MOFunction.
				MOProcedure };
		copyAsMethod;
		installInto: fylgja.
	" By default when going to java "
	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destination);
		anyModelEntityOfTypesWhenGoingClass: { 
				MOGlobalVariable.
				MOGlobalConstant };
		copyAsAttribute;
		installInto: fylgja.



	installer := FylgjaRuleInstaller new
		             context: (fylgja selectDerivativeModelFor: destination);
		             anyInvocationTo: #MsgBox;
		             yourself.

	installer invocationToMessageSend
		selector: #log;
		receiverBlock: [ :writer | writer referenceToSelf ];
		withArgumentCollection: [ :arguments :writer | 
			{ (writer constantReferenceNamed: #ERROR) } , arguments ].
	installer installInto: fylgja
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageStepByStepTests >> testErrorHandlingToPackageCroppingInvocables [

	| provenance destination result method |
	provenance := self errorHandlingClass.
	destination := self configPackage.

	self installRulesFor: destination.

	result := fylgja
		          produce: provenance
		          croppingRelationsWith: [ :col | 
		          col reject: [ :c | c to isKindOf: MOInvocable ] ]
		          into: destination.

	self assert: result result allContainments size equals: 0.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode.


	method := result produce: provenance methods first.
	self assert: result result allContainments size equals: 1.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageStepByStepTests >> testModuleCustomerOrdersToPackageCroppingInvocables [

	| provenance destination result |
	provenance := self moduleCustomerOrders.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja
		          produce: provenance
		          croppingRelationsWith: [ :col | 
		          col reject: [ :c | c to isKindOf: MOInvocable ] ]
		          into: destination.
	self assert: result result types first allContainments size equals: 0.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode.


	result
		produce: provenance invocables first
		into: result result types first.
	self assert: result result types first allContainments size equals: 1.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageStepByStepTests >> testModuleDomainFunctionWrappersToPackageCroppingInvocables [

	| provenance destination result |
	provenance := self moduleDomainFunctionWrappers.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja
		          produce: provenance
		          croppingRelationsWith: [ :col | 
		          col reject: [ :c | c to isKindOf: MOInvocable ] ]
		          into: destination.
	self assert: result result types first allContainments size equals: 0.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode.


	result
		produce: provenance invocables first
		into: result result types first.
	self assert: result result types first allContainments size equals: 1.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageStepByStepTests >> testModuleInventoryToPackageCroppingInvocables [

	| provenance destination result |
	provenance := self moduleInventory.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja
		          produce: provenance
		          croppingRelationsWith: [ :col | 
		          col reject: [ :c | c to isKindOf: MOInvocable ] ]
		          into: destination.
	self assert: result result types first allContainments size equals: 1.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode.


	result
		produce: provenance invocables first
		into: result result types first.
	self assert: result result types first allContainments size equals: 2.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageStepByStepTests >> testModulePrivilegesToPackageCroppingInvocables [

	| provenance destination result |
	provenance := self modulePrivileges.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja
		          produce: provenance
		          croppingRelationsWith: [ :col | 
		          col reject: [ :c | c to isKindOf: MOInvocable ] ]
		          into: destination.
	self assert: result result types first allContainments size equals: 0.
	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageStepByStepTests >> testModulePurchaseOrdersToPackageCroppingInvocables [

	| provenance destination result |
	provenance := self modulePurchaseOrders.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja
		          produce: provenance
		          croppingRelationsWith: [ :col | 
		          col reject: [ :c | c to isKindOf: MOInvocable ] ]
		          into: destination.
	self assert: result result types first allContainments size equals: 0.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode.


	result
		produce: provenance invocables first
		into: result result types first.
	self assert: result result types first allContainments size equals: 1.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageStepByStepTests >> testModuleReflectiveToPackageCroppingInvocables [

	| provenance destination result |
	provenance := self moduleReflective.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja
		          produce: provenance
		          croppingRelationsWith: [ :col | 
		          col reject: [ :c | c to isKindOf: MOInvocable ] ]
		          into: destination.
	self assert: result result types first allContainments size equals: 0.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode.


	result
		produce: provenance invocables first
		into: result result types first.
	self assert: result result types first allContainments size equals: 1.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageStepByStepTests >> testModuleUtilitiesToPackageCroppingInvocables [

	| provenance destination result |
	provenance := self moduleUtilities.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja
		          produce: provenance
		          croppingRelationsWith: [ :col | 
		          col reject: [ :c | c to isKindOf: MOInvocable ] ]
		          into: destination.
	self assert: result result types first allContainments size equals: 1.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode.


	result
		produce: provenance invocables first
		into: result result types first.
	self assert: result result types first allContainments size equals: 2.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageStepByStepTests >> testRecordsetWrapperToPackageCroppingInvocables [

	| provenance destination result |
	provenance := self recordsetWrapper.
	destination := self configPackage.


	self installRulesFor: destination.

	result := fylgja
		          produce: provenance
		          croppingRelationsWith: [ :col | 
		          col reject: [ :c | c to isKindOf: MOInvocable ] ]
		          into: destination.
	self assert: result result allContainments size equals: 1.


	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode.

	result produce: provenance methods first.
	self assert: result result allContainments size equals: 2.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]
