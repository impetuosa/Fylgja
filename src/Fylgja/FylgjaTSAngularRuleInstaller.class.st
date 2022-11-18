Class {
	#name : #FylgjaTSAngularRuleInstaller,
	#superclass : #FylgjaNorthwindRuleInstaller,
	#instVars : [
		'angular'
	],
	#category : #'Fylgja-UI'
}

{ #category : #general }
FylgjaTSAngularRuleInstaller >> angular: aModel [

	angular := aModel
]

{ #category : #initialization }
FylgjaTSAngularRuleInstaller >> angularPackage [

	^ angular packages detect: [ :p | p name = 'app' ]
]

{ #category : #general }
FylgjaTSAngularRuleInstaller >> installAngularTx [

	FylgjaRuleInstaller new
		context: angular root;
		anyAlceDBEntity;
		dbEntityToAngularModel;
		installInto: fylgja.


	FylgjaRuleInstaller new
		context: angular root;
		anyJavaMethodAnnotatedWith:
			#( PostMapping DeleteMapping GetMapping RequestMapping )
		transferredToTypescriptDecoratedWith: #( Injectable );
		migrateAsURLCall; 
		installInto: fylgja.


	FylgjaRuleInstaller new
		context: angular root;
		any: MOAlceForm migratingTo: MOAngularModule;
		applyAllOperations: [ :i | 
			{ 
				i formToAngularService.
				i formToAngularComponent } ];
		installInto: fylgja
]

{ #category : #general }
FylgjaTSAngularRuleInstaller >> installRules [

	super installRules.
	self installTsLanguageTx.
	self installAngularTx
]

{ #category : #general }
FylgjaTSAngularRuleInstaller >> installTsLanguageTx [

	FylgjaRuleInstaller new
		context: angular root;
		prefixUnaryOperator: #Not;
		replacePrefixUnaryOperatorWith: #!;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: angular root;
		binaryOperator: #Is;
		replaceOperatorWith: #==;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: angular root;
		binaryOperator: #And;
		replaceOperatorWith: #&&;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: angular root;
		binaryOperator: #Or;
		replaceOperatorWith: #'||';
		installInto: fylgja.


	FylgjaRuleInstaller new
		context: angular root;
		binaryOperator: #=;
		replaceOperatorWith: #==;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: angular root;
		binaryOperator: #&;
		replaceOperatorWith: #+;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: angular root;
		binaryOperator: #<>;
		replaceOperatorWith: #!=;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: angular root;
		referenceNamed: 'vbCrLf';
		replaceWithStringLiteral: '\r\n';
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: angular root;
		anyTypeReferenceNamed: #Boolean;
		copyAsTypesReferenceNamed: #bool;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: angular root;
		anyAlceModule;
		copyAsPublicClass;
		installInto: fylgja.



	FylgjaRuleInstaller new
		atLanguageNamed: angular name;
		anyKindOfClass;
		copyAsPublicTypescriptClass;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: angular root;
		anyOnErrorGoToBlockTransformableToTryCatch;
		onErrorGoToToTryCatch;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: angular root;
		anyTypeReferenceNamed: #Variant;
		copyAsTypesReferenceNamed: #Object;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: angular root;
		anyTypeReferenceNamed: '#_TypeUndefined';
		copyAsTypesReferenceNamed: #Object;
		installInto: fylgja.


	FylgjaRuleInstaller new
		atLanguageNamed: #angular;
		anyInvocation;
		invocationToMessageSendToSelf;
		installInto: fylgja.

	" By default when going to ts "
	FylgjaRuleInstaller new
		context: angular root;
		anyModelEntityOfTypesWhenGoingClass: { 
				MOClassFunction.
				MOClassProcedure.
				MOFunction.
				MOProcedure };
		copyAsMethod;
		installInto: fylgja.
	" By default when going to ts "

	FylgjaRuleInstaller new
		context: angular root;
		anyModelEntityOfTypesWhenGoingClass: { 
				MOGlobalVariable.
				MOGlobalConstant };
		copyAsAttribute;
		installInto: fylgja.


	FylgjaRuleInstaller new
		atLanguageNamed: #angular;
		whenIsReferenceWithCandidates: { 
				self accessDbMemoType.
				self accessDbTextType };
		bindRewriteTo: self tsString;
		installInto: fylgja.

	FylgjaRuleInstaller new
		atLanguageNamed: #angular;
		whenIsReferenceWithCandidates: { self accessDbLongType };
		bindRewriteTo: self tsBigInt;
		installInto: fylgja
]

{ #category : #general }
FylgjaTSAngularRuleInstaller >> tsBigInt [

	^ (angular entities select: [ :a | 
		   (a isKindOf: MOType) and: [ a name = 'bigint' ] ]) first
]

{ #category : #general }
FylgjaTSAngularRuleInstaller >> tsString [

	^ (angular entities select: [ :a | 
		   (a isKindOf: MOClass) and: [ a name = 'string' ] ]) first
]
