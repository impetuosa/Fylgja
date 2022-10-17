Class {
	#name : #FylgjaMigrateDeclarationIntoPackageTests,
	#superclass : #NotThatGoodTests,
	#category : #'Fylgja-Test'
}

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> installRulesFor: destination [

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
		anyBindableEntity;
		mappingLinkedStubInstall;
		installInto: fylgja.

	FylgjaRuleInstaller new
		topLevel;
		anyReferenceWithCandidate;
		returnSameBinding;
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
FylgjaMigrateDeclarationIntoPackageTests >> testErrorHandlingToPackage [

	| provenance destination result |
	provenance := self errorHandlingClass.
	destination := self javaControllerPackage.

	self installRulesFor: destination.


	result := fylgja produce: provenance into: destination.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testErrorHandlingToPackageOnlyCopy [

	| provenance destination result |
	provenance := self errorHandlingClass.
	destination := self javaControllerPackage.
	fylgja activateTracing.


	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.
		
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



	result := fylgja produce: provenance into: destination.

	" When copying all the produced things should be of the same type "
	self assertTracedClasses.

	" When copying all the produced things look similar from the point of view of composition "
	self assertProducedElementsAreEquivalentBut: [ :a | 
		a third isFylgjaStub or: [ 
			self
				assert: a third allExpressionRelations first name
				equals: #packageReference.
			self assert: a third allExpressionRelations size equals: 1.
			self assert: a first to allExpressionRelations size equals: 0.
			true ] ]
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModuleCustomerOrdersOnlyCopy [

	| provenance destination result |
	provenance := self moduleCustomerOrders.
	destination := self configPackage.
	fylgja activateTracing.


	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.
		
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



	result := fylgja produce: provenance into: destination.
	" When copying all the produced things should be of the same type "
	self assertTracedClasses.

	" When copying all the produced things look similar from the point of view of composition "
	self assertProducedElementsAreEquivalent
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModuleCustomerOrdersToPackage [

	| provenance destination result |
	provenance := self moduleCustomerOrders.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja produce: provenance into: destination.

	result forceMap.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModuleDomainFunctionWrappersOnlyCopy [

	| provenance destination result |
	provenance := self moduleDomainFunctionWrappers.
	destination := self configPackage.
	fylgja activateTracing.


	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.
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



	result := fylgja produce: provenance into: destination.
	" When copying all the produced things should be of the same type "
	self assertTracedClasses.

	" When copying all the produced things look similar from the point of view of composition "
	self assertProducedElementsAreEquivalent
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModuleDomainFunctionWrappersToPackage [

	| provenance destination result |
	provenance := self moduleDomainFunctionWrappers.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja produce: provenance into: destination.
	result forceMap.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModuleInventoryOnlyCopy [

	| provenance destination result |
	provenance := self moduleInventory.
	destination := self configPackage.
	fylgja activateTracing.


	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.
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


	result := fylgja produce: provenance into: destination.
	" When copying all the produced things should be of the same type "
	self assertTracedClasses.

	" When copying all the produced things look similar from the point of view of composition "
	self assertProducedElementsAreEquivalent
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModuleInventoryToPackage [

	| provenance destination result |
	provenance := self moduleInventory.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja produce: provenance into: destination.
	result forceMap.
	
	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModulePrivilegesOnlyCopy [

	| provenance destination result |
	provenance := self modulePrivileges.
	destination := self configPackage.
	fylgja activateTracing.


	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.
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


	result := fylgja produce: provenance into: destination.
	" When copying all the produced things should be of the same type "
	self assertTracedClasses.

	" When copying all the produced things look similar from the point of view of composition "
	self assertProducedElementsAreEquivalent
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModulePrivilegesToPackage [

	| provenance destination result |
	provenance := self modulePrivileges.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja produce: provenance into: destination.
	result forceMap.
	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModulePurchaseOrdersOnlyCopy [

	| provenance destination result |
	provenance := self modulePurchaseOrders.
	destination := self configPackage.
	fylgja activateTracing.


	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.

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

	result := fylgja produce: provenance into: destination.
	" When copying all the produced things should be of the same type "
	self assertTracedClasses.

	" When copying all the produced things look similar from the point of view of composition "
	self assertProducedElementsAreEquivalent
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModulePurchaseOrdersToPackage [

	| provenance destination result |
	provenance := self modulePurchaseOrders.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja produce: provenance into: destination.
	result forceMap.
	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModuleReflectiveOnlyCopy [

	| provenance destination result |
	provenance := self moduleReflective.
	destination := self configPackage.
	fylgja activateTracing.


	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.
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


	result := fylgja produce: provenance into: destination.
	" When copying all the produced things should be of the same type "
	self assertTracedClasses.

	" When copying all the produced things look similar from the point of view of composition "
	self assertProducedElementsAreEquivalent
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModuleReflectiveToPackage [

	| provenance destination result |
	provenance := self moduleReflective.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja produce: provenance into: destination.
	result forceMap.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModuleUtilitiesOnlyCopy [

	| provenance destination result |
	provenance := self moduleUtilities.
	destination := self configPackage.
	fylgja activateTracing.


	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.
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


	result := fylgja produce: provenance into: destination.
	" When copying all the produced things should be of the same type "
	self assertTracedClasses.

	" When copying all the produced things look similar from the point of view of composition "
	self assertProducedElementsAreEquivalent
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testModuleUtilitiesToPackage [

	| provenance destination result |
	provenance := self moduleUtilities.
	destination := self configPackage.

	self installRulesFor: destination.


	result := fylgja produce: provenance into: destination.
	result forceMap.
	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testRecordsetWrapperToPackage [

	| provenance destination result |
	provenance := self recordsetWrapper.
	destination := self configPackage.


	self installRulesFor: destination.

	result := fylgja produce: provenance into: destination.
	result forceMap.
	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testRecordsetWrapperoPackageOnlyCopy [

	| provenance destination result |
	provenance := self recordsetWrapper.
	destination := self configPackage.
	fylgja activateTracing.


	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.


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


	result := fylgja produce: provenance into: destination.
	" When copying all the produced things should be of the same type "
	self assertTracedClasses.

	" When copying all the produced things look similar from the point of view of composition "
	self assertProducedElementsAreEquivalentBut: [ :a | 
		self
			assert: a third allExpressionRelations first name
			equals: #packageReference.
		self assert: a third allExpressionRelations size equals: 1.
		self assert: a first to allExpressionRelations size equals: 0.
		true ]
]
