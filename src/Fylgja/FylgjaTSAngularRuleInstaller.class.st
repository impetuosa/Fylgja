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
		atLanguageNamed: angular name;
		anyAlceForm;
		applyAllOperations: [ :i | 
			{ 
				i formToAngularModel.
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

	" By default when going to java "
	FylgjaRuleInstaller new
		context: angular root;
		anyModelEntityOfTypesWhenGoingClass: { 
				MOClassFunction.
				MOClassProcedure.
				MOFunction.
				MOProcedure };
		copyAsMethod;
		installInto: fylgja.
	" By default when going to java "
	
	FylgjaRuleInstaller new
		context: angular root;
		anyModelEntityOfTypesWhenGoingClass: { 
				MOGlobalVariable.
				MOGlobalConstant };
		copyAsAttribute;
		installInto: fylgja.


]
