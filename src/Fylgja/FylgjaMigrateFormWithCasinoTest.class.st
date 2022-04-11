Class {
	#name : #FylgjaMigrateFormWithCasinoTest,
	#superclass : #NotThatGoodTests,
	#category : #'Fylgja-Test'
}

{ #category : #initialization }
FylgjaMigrateFormWithCasinoTest >> installRulesFor: destination [

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
		mappingStubInstall;
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
FylgjaMigrateFormWithCasinoTest >> testEmployeeDetailsFormToAngularComponent [

	| provenance destination result |
	provenance := self employeeDetails.
	destination := self angularPackage .
	
	
	self installRulesFor: destination.
	
	
	FylgjaRuleInstaller new
		context: destination;
		anyAlceForm ;
		formToAngularComponent;
		installInto: fylgja.
	
	

	result := fylgja produce: provenance into: destination.
	result reapplyMappingRulesOnStubs.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateFormWithCasinoTest >> testEmployeeDetailsFormToAngularModel [

	| provenance destination result |
	provenance := self employeeDetails.
	destination := self angularPackage .
	
	
	self installRulesFor: destination.
	
	
	FylgjaRuleInstaller new
		context: destination;
		anyAlceForm ;
		formToAngularModel;
		installInto: fylgja.
	
	

	result := fylgja produce: provenance into: destination.
	result reapplyMappingRulesOnStubs.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateFormWithCasinoTest >> testEmployeeDetailsFormToAngularService [

	| provenance destination result |
	provenance := self employeeDetails.
	destination := self angularPackage .
	
	
	self installRulesFor: destination.
	
	
	FylgjaRuleInstaller new
		context: destination;
		anyAlceForm ;
		formToAngularService;
		installInto: fylgja.
	

	result := fylgja produce: provenance into: destination.
	result reapplyMappingRulesOnStubs.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateFormWithCasinoTest >> testEmployeeDetailsFormToController [

	| provenance destination result |
	provenance := self employeeDetails.
	destination := self javaControllerPackage .
	
	
	self installRulesFor: destination.
	
	
	FylgjaRuleInstaller new
		context: destination;
		anyAlceForm ;
		formToSpringController;
		installInto: fylgja.
	
	

	result := fylgja produce: provenance into: destination.
	result reapplyMappingRulesOnStubs.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateFormWithCasinoTest >> testEmployeeDetailsFormToDAO [

	| provenance destination result |
	provenance := self employeeDetails.
	destination := self javaDaoPackage .
	
	
	self installRulesFor: destination.
	
	
	FylgjaRuleInstaller new
		context: destination;
		anyAlceForm ;
		formToSpringDAO;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: destination;
		whenIsReferenceWithCandidates: { 
				self accessDbMemoType.
				self accessDbTextType };
		bindRewriteTo: self javaString;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: destination;
		whenIsReferenceWithCandidate: self accessDbAttachment;
		bindRewriteTo: self javaSqlBlob;
		installInto: fylgja.

	

	result := fylgja produce: provenance into: destination.
	result reapplyMappingRulesOnStubs.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateFormWithCasinoTest >> testEmployeeDetailsFormToModel [

	| provenance destination result |
	provenance := self employeeDetails.
	destination := self javaModelPackage.


	self installRulesFor: destination.


	FylgjaRuleInstaller new
		context: destination;
		anyAlceForm;
		formToSpringModel;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: destination;
		whenIsReferenceWithCandidates: { 
				self accessDbMemoType.
				self accessDbTextType };
		bindRewriteTo: self javaString;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: destination;
		whenIsReferenceWithCandidate: self accessDbAttachment;
		bindRewriteTo: self javaSqlBlob;
		installInto: fylgja.


	result := fylgja produce: provenance into: destination.
	result reapplyMappingRulesOnStubs.
	result result produceCode inspect.
	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateFormWithCasinoTest >> testEmployeeDetailsFormToService [

	| provenance destination result |
	provenance := self employeeDetails.
	destination := self javaServicePackage .
	
	
	self installRulesFor: destination.
	
	
	FylgjaRuleInstaller new
		context: destination;
		anyAlceForm ;
		formToSpringService;
		installInto: fylgja.
	

	result := fylgja produce: provenance into: destination.
	result reapplyMappingRulesOnStubs.

	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]
