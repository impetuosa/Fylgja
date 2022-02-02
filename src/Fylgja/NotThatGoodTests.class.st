Class {
	#name : #NotThatGoodTests,
	#superclass : #TestCase,
	#instVars : [
		'fylgja',
		'angular',
		'java',
		'northwind'
	],
	#category : #'Fylgja-Test'
}

{ #category : #initialization }
NotThatGoodTests >> angularClassStudent [

	^ ((angular packages detect: [ :p | p name = 'app' ]) types detect: [ : a | a isKindOf: MOAngularClass  ]) classRepresentation
]

{ #category : #initialization }
NotThatGoodTests >> angularPackage [

	^ angular packages detect: [ :p | p name = 'app' ]
]

{ #category : #asserting }
NotThatGoodTests >> assert: newClass isKindOf: aType [

	self assert: (newClass isKindOf: aType)
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> blockDataSourceConfigClassConfigPackage [

	^ self dataSourceConfigClassConfigPackage block
]

{ #category : #initialization }
NotThatGoodTests >> configClassConfigPackage [

	^ self configPackage allTypes detect: [ :t | t name = 'Config' ]
]

{ #category : #initialization }
NotThatGoodTests >> configPackage [

	^ java packages detect: [ :p | p name = 'config' ]
]

{ #category : #initialization }
NotThatGoodTests >> dataSourceConfigClassConfigPackage [

	^ self configClassConfigPackage methods detect: [ :i | 
		  i selector = 'dataSource' ]
]

{ #category : #initialization }
NotThatGoodTests >> errorHandlingClass [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: JinDAMClass) and: [ a name = 'ErrorHandling' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> logErrorFunction [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: JinDAMInvocable) and: [ 
			  a name = 'LogError' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> logErrorFunctionVariable [

	^ self logErrorFunction localVariables second
]

{ #category : #initialization }
NotThatGoodTests >> modelPackage [

	^ java packages detect: [ :p | p name = 'Model' ]
]

{ #category : #initialization }
NotThatGoodTests >> modelStubClass [

	^ (java packages detect: [ :p | p name = 'Model' ]) allTypes detect: [ 
		  :t | t name = 'Stub' ]
]

{ #category : #initialization }
NotThatGoodTests >> runCaseManaged [ 
	^ self runCase 
]

{ #category : #initialization }
NotThatGoodTests >> setUp [

	super setUp.

	fylgja := FylgjaMigrationEngine new.
	northwind := JinDAMModel northwind.
	angular := MOAngularLoader northwind.
	java := MOJavaMavenProjectLoader northwind.


	fylgja
		addModel: northwind;
		addModel: angular;
		addModel: java
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> statementDataSourceConfigClassConfigPackage [

	^ self dataSourceConfigClassConfigPackage block statements first
]

{ #category : #initialization }
NotThatGoodTests >> testAllConditionMatchesTheCase [

	| variable destinationContext |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.

	self assert:
		(fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) isEmpty.
			
	FylgjaRuleInstaller new
		context: destinationContext;
		anyEntity;
		copy;
		installInto: fylgja.

	self assert:
		(fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) size = 1
]

{ #category : #initialization }
NotThatGoodTests >> testDataSourceToErrorHandling [

	| debug destination |
	debug := self dataSourceConfigClassConfigPackage.
	destination := self errorHandlingClass.

	self should: [ fylgja get: debug for: destination ] raise: NotFound
]

{ #category : #initialization }
NotThatGoodTests >> testEntityEqualsConditionMatchesTheCase [

	| variable destinationContext |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.

	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) isEmpty.

	FylgjaRuleInstaller new
		context: destinationContext;
		whenEntityIs: variable;
		copy;
		installInto: fylgja.

	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) size = 1
]

{ #category : #initialization }
NotThatGoodTests >> testEntityIdenticalConditionMatchesTheCase [

	| variable destinationContext |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.

	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) isEmpty.

	FylgjaRuleInstaller new
		context: destinationContext;
		whenEntityIsIdenticalTo: variable;
		copy;
		installInto: fylgja.

	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) size = 1
]

{ #category : #initialization }
NotThatGoodTests >> testLogErrorToClassNoMappingExists [

	| debug destination |
	debug := self logErrorFunction.
	destination := self modelStubClass.

	self should: [ fylgja get: debug for: destination ] raise: NotFound
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> testProduceMethodIntoClassByCopyNodeTransformAddRuleToMapBooleanToBool [

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
	self deny: result result parent == destinationClass.
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
NotThatGoodTests >> testProduceMethodIntoClassByCopyNodeTransformAddRuleToMapVariantUsesToObjectDefault [

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
NotThatGoodTests >> testProduceMethodIntoClassByCopyNodeTransformDefault [

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
NotThatGoodTests >> testProduceMethodIntoClassByCopyNodeTransformDefaultFailsForMessageNotUnderstood [

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
NotThatGoodTests >> testProduceMethodIntoClassByCopyNodeTransformRewriteMsgBoxInvocationToSelfLogError [

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
NotThatGoodTests >> testProduceMethodIntoClassByCopyNodeTransformRewriteMsgBoxInvocationToSelfLogErrorGenerate [

	| function destinationClass result installer vbCrlf |
	function := self logErrorFunction.
	destinationClass := self configClassConfigPackage.
	vbCrlf := self vbCrlf.



	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destinationClass);
		binaryOperator: #&;
		replaceOperatorWith: #+;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destinationClass);
		binaryOperator: #<>;
		replaceOperatorWith: #!=;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destinationClass);
		referenceNamed: 'vbCrLf';
		replaceWithStringLiteral: '\r\n';
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destinationClass);
		anyTypeReferenceNamed: #Boolean;
		copyAsTypesReferenceNamed: #bool;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: (fylgja selectDerivativeModelFor: destinationClass);
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

	self
		assert: (JavaParser parse: result result parent produceCode)
		isKindOf: JavaProgramFileNode
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> testProduceVariableIntoMethodByCopyNodeTransformDefault [

	| variable destinationContext result |
	variable := self logErrorFunctionVariable.
	destinationContext := self blockDataSourceConfigClassConfigPackage.

	FylgjaRuleInstaller new
		context: destinationContext;
		anyEntity;
		copy;
		installInto: fylgja.

	result := fylgja produce: variable into: destinationContext.
	self assert: (result result isKindOf: MOVariable).
	self assert: result result language isJava.
	self
		assert: result result parent statements size
		equals: destinationContext statements size + 1.
	1 to: destinationContext statements size do: [ :i | 
		self assert: (result result parent statements at: i)
			== (destinationContext statements at: i) ].
	self assert:
		result result parent statements last name = variable name.
	self assert: result result parent statements last language isJava.
	self assert: result result statements parent last typeReference name
		= variable type name
]

{ #category : #initialization }
NotThatGoodTests >> testProduceVariableIntoMethodByCopyNodeTransformDefaultNoProducerFails [

	| variable destinationContext result |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.

	self
		should: [ 
		result := fylgja produce: variable into: destinationContext ]
		raise: NotFound
]

{ #category : #initialization }
NotThatGoodTests >> testRespondsToPatternConditionMatchesTheCase [

	| variable destinationContext moVariable |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.
	moVariable := (fylgja derivative readerFor: variable) read: variable.

	self assert: (fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) isEmpty.

	FylgjaRuleInstaller new
		context: destinationContext;
		matchesPattern: (FylgjaPatternBuilder new
				 parse: ' dim $ as String ';
				 parser: VBParser;
				 reader: MOJinDAMModelReader ;
				 model: MOModel newMicrosoftAccess;
				 build);
		copy;
		installInto: fylgja.

	self assert: (fylgja
			 lookupRulesForProducing: moVariable
			 toContext: destinationContext) size = 1
]

{ #category : #initialization }
NotThatGoodTests >> testTypeConditionMatchesTheCase [

	| variable destinationContext |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.

	self assert:
		(fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) isEmpty.

	FylgjaRuleInstaller new
		context: destinationContext;
		whenTypeOfModelEntityIs: variable class;
		copy;
		installInto: fylgja.

	self assert:
		(fylgja
			 lookupRulesForProducing: variable
			 toContext: destinationContext) size = 1
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> vbCrlf [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: JinDAMAttribute) and: [ a name = 'vbCrLf' ] ]
]
