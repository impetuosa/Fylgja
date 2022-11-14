Class {
	#name : #FylgjaJavaSpringRuleInstaller,
	#superclass : #FylgjaNorthwindRuleInstaller,
	#instVars : [
		'java'
	],
	#category : #'Fylgja-UI'
}

{ #category : #initialization }
FylgjaJavaSpringRuleInstaller >> configPackage [

	^ java packages detect: [ :p | p name = 'config' ]
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installJavaLanguageTx [

	| installer |
	FylgjaRuleInstaller new
		context: java root;
		prefixUnaryOperator: #Not;
		replacePrefixUnaryOperatorWith: #!;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: java root;
		binaryOperator: #Is;
		replaceOperatorWith: #==;
		installInto: fylgja.


	FylgjaRuleInstaller new
		context: java root;
		binaryOperator: #And;
		replaceOperatorWith: #&&;
		installInto: fylgja.


	FylgjaRuleInstaller new
		context: java root;
		binaryOperator: #Or;
		replaceOperatorWith: #'||';
		installInto: fylgja.



	FylgjaRuleInstaller new
		context: java root;
		binaryOperator: #=;
		replaceOperatorWith: #==;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: java root;
		binaryOperator: #&;
		replaceOperatorWith: #+;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: java root;
		binaryOperator: #<>;
		replaceOperatorWith: #!=;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: java root;
		referenceNamed: 'vbCrLf';
		replaceWithStringLiteral: '\r\n';
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: java root;
		anyTypeReferenceNamed: #Boolean;
		copyAsTypesReferenceNamed: #bool;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: java root;
		anyAlceModule;
		copyAsPublicClass;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: java root;
		anyOnErrorGoToBlockTransformableToTryCatch;
		onErrorGoToToTryCatch;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: java root;
		anyTypeReferenceNamed: #Variant;
		copyAsTypesReferenceNamed: #Object;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: java root;
		anyTypeReferenceNamed: '#_TypeUndefined';
		copyAsTypesReferenceNamed: #Object;
		installInto: fylgja.


	"

	FylgjaRuleInstaller new
		atLanguageNamed: java name;
		anyInvocation;
		invocationToMessageSendToSelf;
		installInto: fylgja."

	" By default when going to java "
	FylgjaRuleInstaller new
		context: java root;
		anyModelEntityOfTypesWhenGoingClass: { 
				MOVariableAccessor.
				MOAttributeAccessor.
				MOClassFunction.
				MOClassProcedure.
				MOFunction.
				MOProcedure };
		copyAsMethod;
		installInto: fylgja.
	" By default when going to java "
	FylgjaRuleInstaller new
		context: java root;
		anyModelEntityOfTypesWhenGoingClass: { 
				MOGlobalVariable.
				MOGlobalConstant };
		copyAsAttribute;
		installInto: fylgja
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installJavaSpring [

	"Types"

	self accessDbMemoType ifNotNil: [ 
		FylgjaRuleInstaller new
			atLanguageNamed: java name;
			whenIsReferenceWithCandidates: { 
					self accessDbMemoType.
					self accessDbTextType };
			bindRewriteTo: self javaString;
			installInto: fylgja ].


	FylgjaRuleInstaller new
		atLanguageNamed: java name;
		whenIsReferenceWithCandidates: { self accessDbLongType };
		bindRewriteTo: self javaLong;
		installInto: fylgja.

	self accessDbAttachment ifNotNil: [ 
		FylgjaRuleInstaller new
			atLanguageNamed: java name;
			whenIsReferenceWithCandidate: self accessDbAttachment;
			bindRewriteTo: self javaSqlBlob;
			installInto: fylgja ].






	" Model "

	FylgjaRuleInstaller new
		context: self javaModelPackage;
		anyAlceForm;
		formToSpringModel;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: self javaModelPackage;
		anyAlceDBEntity;
		dbEntityToSpringModel;
		installInto: fylgja.



	" DAO "
	FylgjaRuleInstaller new
		context: self javaDaoPackage;
		anyAlceDBEntity;
		dbEntityToSpringDAO;
		installInto: fylgja.


	FylgjaRuleInstaller new
		context: self javaDaoPackage;
		anyAlceForm;
		formToSpringDAO;
		installInto: fylgja.

	" Service "


	FylgjaRuleInstaller new
		context: self javaServicePackage;
		anyAlceForm;
		formToSpringService;
		installInto: fylgja.


	"Controller "
	FylgjaRuleInstaller new
		context: self javaControllerPackage;
		anyAlceForm;
		formToSpringController: 'http://localhost:8081'
		apiURLExtention: '/api';
		installInto: fylgja.

	FylgjaRuleInstaller new
		atLanguageNamed: java name;
		anyAlceForm;
		dispatchToSubPackages: { 
				self javaModelPackage.
				self javaDaoPackage.
				self javaServicePackage.
				self javaControllerPackage };
		installInto: fylgja.


	FylgjaRuleInstaller new
		atLanguageNamed: java name;
		anyAlceDBEntity;
		dispatchToSubPackages: { 
				self javaModelPackage.
				self javaDaoPackage };
		installInto: fylgja
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installRules [

	super installRules.
	self installJavaLanguageTx.
	self installJavaSpring
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> java: aModel [

	java := aModel
]

{ #category : #initialization }
FylgjaJavaSpringRuleInstaller >> javaControllerPackage [

	^ java packages detect: [ :p | p name = 'Controller' ]
]

{ #category : #initialization }
FylgjaJavaSpringRuleInstaller >> javaDaoPackage [

	^ java packages detect: [ :p | p name = 'DAO' ]
]

{ #category : #'as yet unclassified' }
FylgjaJavaSpringRuleInstaller >> javaLong [

	^ (java entities select: [ :a | 
		   (a isKindOf: MOClass) and: [ a name = 'Long' ] ]) first
]

{ #category : #initialization }
FylgjaJavaSpringRuleInstaller >> javaModelPackage [

	^ java packages detect: [ :p | p name = 'Model' ]
]

{ #category : #'as yet unclassified' }
FylgjaJavaSpringRuleInstaller >> javaServicePackage [

	
	^ java packages detect: [ :p | p name = 'Service' ]
]

{ #category : #'as yet unclassified' }
FylgjaJavaSpringRuleInstaller >> javaSqlBlob [

	^ (java catalog entities select: [ :a | 
		   (a isKindOf: MOClassType) and: [ a name = 'Blob' ] ]) first
]

{ #category : #'as yet unclassified' }
FylgjaJavaSpringRuleInstaller >> javaString [

	^ (java entities select: [ :a | 
		   (a isKindOf: MOClass) and: [ a name = 'String' ] ]) first
]

{ #category : #initialization }
FylgjaJavaSpringRuleInstaller >> modelPackage [

	^ java packages detect: [ :p | p name = 'Model' ]
]
