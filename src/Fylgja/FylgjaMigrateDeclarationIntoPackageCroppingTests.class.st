Class {
	#name : #FylgjaMigrateDeclarationIntoPackageCroppingTests,
	#superclass : #NotThatGoodTests,
	#category : #'Fylgja-Test'
}

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageCroppingTests >> installRulesFor: destination [

	| vbCrlf installer |
	vbCrlf := self vbCrlf.

	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		mappingStubInstall;
		installInto: fylgja.
	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
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
FylgjaMigrateDeclarationIntoPackageCroppingTests >> testErrorHandlingToPackageCroppingInvocables [

	| provenance destination result |
	provenance := self errorHandlingClass.
	destination := self configPackage.

	self installRulesFor: destination.
	

	result := fylgja
		          produce: provenance
		          croppingRelationsWith: [ :col |
		          col reject: [ :c | c to isKindOf: MOInvocable ].  ]
		          into: destination.
		
	self assert: result result allContainments size equals: 0.
	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageCroppingTests >> testModuleCustomerOrdersToPackageCroppingInvocables [

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
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageCroppingTests >> testModuleDomainFunctionWrappersToPackageCroppingInvocables [

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
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageCroppingTests >> testModuleInventoryToPackageCroppingInvocables [

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
	self assert:
		result result types first allContainments first isVariable.
	self
		assert: result result types first allContainments first kindString
		equals: #'CONST ATTR'.
	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageCroppingTests >> testModulePrivilegesToPackageCroppingInvocables [

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
FylgjaMigrateDeclarationIntoPackageCroppingTests >> testModulePurchaseOrdersToPackageCroppingInvocables [

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
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageCroppingTests >> testModuleReflectiveToPackageCroppingInvocables [

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
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageCroppingTests >> testModuleUtilitiesToPackageCroppingInvocables [

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
	self assert:
		result result types first allContainments first isVariable.
	self
		assert: result result types first allContainments first kindString
		equals: 'ATTR'.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageCroppingTests >> testRecordsetWrapperToPackageCroppingInvocables [

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
	self assert: result result allContainments first isVariable.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]
