Class {
	#name : #FylgjaMigrateDeclarationIntoPackageTests,
	#superclass : #NotThatGoodTests,
	#category : #'Fylgja-Test'
}

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testErrorHandlingToPackage [

	| provenance destination result installer vbCrlf |
	provenance :=  self errorHandlingClass.
	destination := self configPackage.
	vbCrlf := self vbCrlf.



	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
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
		anyTypeReferenceNamed: #Variant;
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
		anyModelEntityOfTypes: { 
				MOFunction.
				MOProcedure };
		copyAsMethod;
		installInto: fylgja.

	installer := FylgjaRuleInstaller new
		             context:
			             (fylgja selectDerivativeModelFor: destination);
		             anyInvocationTo: #MsgBox;
		             yourself.

	installer invocationToMessageSend
		selector: #log;
		receiverBlock: [ :writer | writer referenceToSelf ];
		withArgumentCollection: [ :arguments :writer | 
			{ (writer constantReferenceNamed: #ERROR) } , arguments ].
	installer installInto: fylgja.

	result := fylgja produce: provenance into: destination.
	 result result produceCode inspect.
	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testErrorHandlingToPackageOnlyCopy [

	| provenance destination result |
	provenance := self errorHandlingClass.
	destination := self configPackage.
	fylgja activateTracing.


	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.


	result := fylgja produce: provenance into: destination.
	" When copying all the produced things should be of the same type "
	self assert:
		(fylgja traces reject: [ :a | a first class = a last class ])
			isEmpty.


	" When copying all the produced things look similar from the point of view of composition "
	self assert: (fylgja traces reject: [ :a | 
			 a first allContainments size = a last allContainments size and: [ 
				 a first allReferences size = a last allReferences size and: [ 
					 a first allExpressions size = a last allExpressions size ] ] ])
			isEmpty
]

{ #category : #initialization }
FylgjaMigrateDeclarationIntoPackageTests >> testRecordsetWrapperToPackage [

	| provenance destination result installer vbCrlf |
	provenance :=  self recordsetWrapper .
	destination := self configPackage.
	vbCrlf := self vbCrlf.



	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
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
		anyTypeReferenceNamed: #Variant;
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
		anyModelEntityOfTypes: { 
				MOFunction.
				MOProcedure };
		copyAsMethod;
		installInto: fylgja.

	installer := FylgjaRuleInstaller new
		             context:
			             (fylgja selectDerivativeModelFor: destination);
		             anyInvocationTo: #MsgBox;
		             yourself.

	installer invocationToMessageSend
		selector: #log;
		receiverBlock: [ :writer | writer referenceToSelf ];
		withArgumentCollection: [ :arguments :writer | 
			{ (writer constantReferenceNamed: #ERROR) } , arguments ].
	installer installInto: fylgja.

	result := fylgja produce: provenance into: destination.
	 result result produceCode inspect.
	self
		assert: (JavaParser parse: result result produceCode)
		isKindOf: JavaProgramFileNode
]
