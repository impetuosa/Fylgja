Class {
	#name : #FylgjaMigrateDeclarationIntoClassTests,
	#superclass : #NotThatGoodTests,
	#category : #'Fylgja-Test'
}

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassTests >> testProduceMethodIntoClassByCopyNodeTransformAddRuleToMapBooleanToBool [

	| function destinationClass result modifiedClass |
	function := self logErrorFunction.
	destinationClass := self configClassConfigPackage.

	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.

	" By default when going to java "
	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destinationClass);
		anyModelEntityOfTypes: { 
				MOFunction.
				MOProcedure };
		copyAsMethod;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destinationClass);
		anyTypeReferenceNamed: #Boolean;
		copyAsTypesReferenceNamed: #bool;
		installInto: fylgja.


	result := fylgja produce: function into: destinationClass.
	self assert: result result isKindOf: MOMethod.

	self assert: result result returnTypeReference name equals: #bool.

	self assert: result result modifiers size equals: 1.
	self assert: result result modifiers first equals: #static.
	self assert: result result language isJava.
	self assert: result result block language isJava.
	self
		assert: result result block statements size
		equals: function block statements size.
	self
		assert: result result parameters size
		equals: function parameters size.

	" First parameter "
	self
		assert: result result parameters first name
		equals: function parameters first name.

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
		equals: #Variant.

	" The second parameter is var-arg kind, without type specification. So it becomes Variant "
	self
		assert: result result parameters second
		isKindOf: MOVariableArgumentsParameter.

	self assert: result result parameters second language isJava.
	self assert:
		result result parameters second typeReference language isJava.


	self assert: result result language isJava.
	self deny: result result parent equals: destinationClass.
	self
		assert:
			(result derivative derivativeModels select: [ :a | 
				 a language isJava ]) size
		equals: 1.
	modifiedClass := (result derivative derivativeModels select: [ :a | 
		                  a language isJava ]) first entities detect: [ :a | 
		                 a = result result parent ].

	self assert: modifiedClass name equals: destinationClass name.
	self
		assert: modifiedClass attributes
		equals: destinationClass attributes.
	self
		assert: modifiedClass methods allButLast
		equals: destinationClass methods.
	self assert: modifiedClass methods last equals: result result
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassTests >> testProduceMethodIntoClassByCopyNodeTransformAddRuleToMapVariantUsesToObjectDefault [

	| function destinationClass result modifiedClass |
	function := self logErrorFunction.
	destinationClass := self configClassConfigPackage.

	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.

	" By default when going to java "
	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destinationClass);
		anyModelEntityOfTypes: { 
				MOFunction.
				MOProcedure };
		copyAsMethod;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destinationClass);
		anyTypeReferenceNamed: #Variant;
		copyAsTypesReferenceNamed: #Object;
		installInto: fylgja.


	result := fylgja produce: function into: destinationClass.
	self assert: result result isKindOf: MOMethod.

	self
		assert: result result returnTypeReference name
		equals: function typeReference name.

	self assert: result result modifiers size equals: 1.
	self assert: result result modifiers first equals: #static.
	self assert: result result language isJava.
	self assert: result result block language isJava.
	self
		assert: result result block statements size
		equals: function block statements size.
	self
		assert: result result parameters size
		equals: function parameters size.

	" First parameter "
	self
		assert: result result parameters first name
		equals: function parameters first name.

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

	" The second parameter is var-arg kind, without type specification. So it becomes Variant "
	self
		assert: result result parameters second
		isKindOf: MOVariableArgumentsParameter.

	self assert: result result parameters second language isJava.
	self assert:
		result result parameters second typeReference language isJava.


	self assert: result result language isJava.
	self deny: destinationClass equals: result result parent.
	modifiedClass := result result parent.
	self assert: modifiedClass name equals: destinationClass name.
	self
		assert: modifiedClass attributes
		equals: destinationClass attributes.
	self
		assert: modifiedClass methods allButLast
		equals: destinationClass methods.
	self assert: modifiedClass methods last equals: result result
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassTests >> testProduceMethodIntoClassByCopyNodeTransformDefault [

	| function destinationClass result modifiedClass |
	function := self logErrorFunction.
	destinationClass := self configClassConfigPackage.

	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.

	" By default when going to java "
	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destinationClass);
		anyModelEntityOfTypes: { 
				MOFunction.
				MOProcedure };
		copyAsMethod;
		installInto: fylgja.


	result := fylgja produce: function into: destinationClass.
	self assert: result result isKindOf: MOMethod.

	self
		assert: result result returnTypeReference name
		equals: function typeReference name.

	self assert: result result modifiers size equals: 1.
	self assert: result result modifiers first equals: #static.
	self assert: result result language isJava.
	self assert: result result block language isJava.
	self assert:
		(result result block statements allSatisfy: [ :a | 
			 a language isJava ]).
	self
		assert: result result block statements size
		equals: function block statements size.
	self
		assert: result result parameters size
		equals: function parameters size.

	" First parameter "
	self
		assert: result result parameters first name
		equals: function parameters first name.
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
		equals: #Variant.

	" The second parameter is var-arg kind, without type specification. So it becomes Variant "
	self
		assert: result result parameters second
		isKindOf: MOVariableArgumentsParameter.

	self assert: result result parameters second language isJava.
	self assert:
		result result parameters second typeReference language isJava.


	self assert: result result language isJava.
	self deny: destinationClass equals: result result parent.
	modifiedClass := result result parent.
	self assert: modifiedClass name equals: destinationClass name.
	self
		assert: modifiedClass attributes
		equals: destinationClass attributes.
	self
		assert: modifiedClass methods allButLast
		equals: destinationClass methods.
	self assert: modifiedClass methods last equals: result result.

	self assert:
		(result allNewEntities select: [ :a | a isKindOf: MOIfElse ]) size
		= 2.
	self assert:
		((result allNewEntities select: [ :a | a isKindOf: MOIfElse ]) 
			 allSatisfy: [ :a | a ifTrue isKindOf: MOBlock ]).

	self assert:
		((result allNewEntities select: [ :a | a isKindOf: MOIfElse ]) 
			 allSatisfy: [ :a | a ifFalse isKindOf: MOBlock ]).
	self assert:
		((result allNewEntities select: [ :a | a isKindOf: MOIfElse ]) 
			 allSatisfy: [ :a | a condition isNotNil ])
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassTests >> testProduceMethodIntoClassByCopyNodeTransformDefaultFailsForMessageNotUnderstood [

	| variable destinationContext result |
	variable := self logErrorFunction.
	destinationContext := self configClassConfigPackage.


	FylgjaRuleInstaller new
		context: destinationContext;
		anyEntity;
		copy;
		installInto: fylgja.

	self
		should: [ 
		result := fylgja produce: variable into: destinationContext ]
		raise: MessageNotUnderstood
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassTests >> testProduceMethodIntoClassByCopyNodeTransformRewriteMsgBoxInvocationToSelfLogError [

	| function destinationClass result modifiedClass installer |
	function := self logErrorFunction.
	destinationClass := self configClassConfigPackage.

	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.

	" By default when going to java "
	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destinationClass);
		anyModelEntityOfTypes: { 
				MOFunction.
				MOProcedure };
		copyAsMethod;
		installInto: fylgja.

	installer := FylgjaRuleInstaller new
		             context:
			             (fylgja selectDerivativeModelFor: destinationClass);
		             anyInvocationTo: #MsgBox;
		             yourself.

	installer invocationToMessageSend
		selector: #log;
		receiverBlock: [ :writer | writer referenceToSelf ];
		withArgumentCollection: [ :arguments :writer | 
			{ (writer constantReferenceNamed: #ERROR) } , arguments ].

	installer installInto: fylgja.


	result := fylgja produce: function into: destinationClass.
	self assert: result result isKindOf: MOMethod.

	self assert: result result returnTypeReference name equals: #Boolean.

	self assert: result result modifiers size equals: 1.
	self assert: result result modifiers first equals: #static.
	self assert: result result language isJava.
	self assert: result result block language isJava.

	self
		assert: result result parameters size
		equals: function parameters size.

	" First parameter "
	self
		assert: result result parameters first name
		equals: function parameters first name.

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
		equals: #Variant.

	" The second parameter is var-arg kind, without type specification. So it becomes Variant "
	self
		assert: result result parameters second
		isKindOf: MOVariableArgumentsParameter.

	self assert: result result parameters second language isJava.
	self assert:
		result result parameters second typeReference language isJava.


	self assert: result result language isJava.
	modifiedClass := result result parent.
	self assert: modifiedClass name equals: destinationClass name.
	self
		assert: modifiedClass attributes
		equals: destinationClass attributes.
	self
		assert: modifiedClass methods allButLast
		equals: destinationClass methods.
	self assert: modifiedClass methods last equals: result result.

	self
		assert: result result block statements size
		equals: function block statements size
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassTests >> testProduceMethodIntoClassByCopyNodeTransformRewriteMsgBoxInvocationToSelfLogErrorGenerate [

	| provenance destination result installer vbCrlf |
	provenance := self logErrorFunction.
	destination := self configClassConfigPackage.
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
	
	self
		assert: (JavaParser parse: result result parent produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #'as yet unclassified' }
FylgjaMigrateDeclarationIntoClassTests >> testProduceMethodIntoClassByCopyOnlyProducesEquivalentThing [

	| provenance destination result |
	provenance := self logErrorFunction.
	destination := self configClassConfigPackage.


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
