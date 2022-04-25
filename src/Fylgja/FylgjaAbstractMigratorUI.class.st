Class {
	#name : #FylgjaAbstractMigratorUI,
	#superclass : #SpPresenter,
	#instVars : [
		'fylgja',
		'northwind',
		'angular',
		'java'
	],
	#category : #'Fylgja-UI'
}

{ #category : #'as yet unclassified' }
FylgjaAbstractMigratorUI >> accessDbAttachment [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOPrimitiveType) and: [ a name = #dbAttachment ] ]
]

{ #category : #'as yet unclassified' }
FylgjaAbstractMigratorUI >> accessDbMemoType [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOPrimitiveType) and: [ a name = #dbMemo ] ]
]

{ #category : #'as yet unclassified' }
FylgjaAbstractMigratorUI >> accessDbTextType [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOPrimitiveType) and: [ a name = #dbText ] ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> angularClassStudent [

	^ ((angular packages detect: [ :p | p name = 'app' ]) types detect: [ : a | a isKindOf: MOAngularClass  ]) classRepresentation
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> angularPackage [

	^ angular packages detect: [ :p | p name = 'app' ]
]

{ #category : #asserting }
FylgjaAbstractMigratorUI >> assert: newClass isKindOf: aType [

	self assert: (newClass isKindOf: aType)
]

{ #category : #asserting }
FylgjaAbstractMigratorUI >> assertAllReferencesHaveCandidate: aFylgjaDerivationResult [

	self assert:
		((self allReferencesFrom: aFylgjaDerivationResult) select: [ :e | 
			 e candidate isNil and: [ e isFylgjaMissingCandidateStub not  ] ]) isEmpty
]

{ #category : #'as yet unclassified' }
FylgjaAbstractMigratorUI >> assertProducedElementsAreEquivalent [

	self assert: (fylgja traces reject: [ :a | 
			 a first to allContainments size = a last allContainments size and: [ 
				 a first to allReferences size = a last allReferences size and: [ 
					 a first to allExpressions size = a last allExpressions size ] ] ])
			isEmpty
]

{ #category : #'as yet unclassified' }
FylgjaAbstractMigratorUI >> assertProducedElementsAreEquivalentBut: aBlock [

	self assert: ((fylgja traces reject: [ :a | 
			  a first to allContainments size = a last allContainments size 
				  and: [ 
					  a first to allReferences size = a last allReferences size and: [ 
						  a first to allExpressions size = a last allExpressions size ] ] ]) 
			 reject: aBlock) isEmpty
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> assertTracedClasses [

	self assert: (fylgja traces reject: [ :a | 
			 a first to class = a last class or: [ 
				 a last isFylgjaStub and: [ a last provenance = a first ] ] ])
			isEmpty
]

{ #category : #'as yet unclassified' }
FylgjaAbstractMigratorUI >> blockDataSourceConfigClassConfigPackage [

	^ self dataSourceConfigClassConfigPackage block
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> configClassConfigPackage [

	^ self configPackage allTypes detect: [ :t | t name = 'Config' ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> configPackage [

	^ java packages detect: [ :p | p name = 'config' ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> dataSourceConfigClassConfigPackage [

	^ self configClassConfigPackage methods detect: [ :i | 
		  i selector = 'dataSource' ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> employeeDetails [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOAlceForm) and: [ a name = 'Form_Employee_Details' ] ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> errorHandlingClass [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOClass) and: [ a name = 'ErrorHandling' ] ]
]

{ #category : #'as yet unclassified' }
FylgjaAbstractMigratorUI >> installJavaLanguageTx [

	|  installer |

	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.


	FylgjaRuleInstaller new
		topLevel;
		anyReferenceWithCandidate;
		returnSameBinding;
		installInto: fylgja.

	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		mappingStubInstall;
		installInto: fylgja.

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




	FylgjaRuleInstaller new
		atLanguageNamed: #java;
		anyInvocation;
		invocationToMessageSendToSelf;
		installInto: fylgja.

	" By default when going to java "
	FylgjaRuleInstaller new
		context: java root;
		anyModelEntityOfTypesWhenGoingClass: { 
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
		installInto: fylgja.



	installer := FylgjaRuleInstaller new
		             context: java root;
		             anyInvocationTo: #MsgBox;
		             yourself.

	installer invocationToMessageSend
		selector: #log;
		receiverBlock: [ :writer | writer referenceToSelf ];
		withArgumentCollection: [ :arguments :writer | 
			{ (writer constantReferenceNamed: #ERROR) } , arguments ].
	installer installInto: fylgja
]

{ #category : #'as yet unclassified' }
FylgjaAbstractMigratorUI >> installJavaSpring [

	"Types"

	FylgjaRuleInstaller new
		atLanguageNamed: #java;
		whenIsReferenceWithCandidates: { 
				self accessDbMemoType.
				self accessDbTextType };
		bindRewriteTo: self javaString;
		installInto: fylgja.

	FylgjaRuleInstaller new
		atLanguageNamed: #java;
		whenIsReferenceWithCandidate: self accessDbAttachment;
		bindRewriteTo: self javaSqlBlob;
		installInto: fylgja.


	" Model "

	FylgjaRuleInstaller new
		context: self javaModelPackage;
		anyAlceForm;
		formToSpringModel;
		installInto: fylgja.


	" DAO "

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
		formToSpringController: 'http://localhost:4200'
		apiURLExtention: '/api';
		installInto: fylgja
]

{ #category : #'as yet unclassified' }
FylgjaAbstractMigratorUI >> installTsLanguageTx [

	|  installer |

	" By default in the system we copy"
	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.


	FylgjaRuleInstaller new
		topLevel;
		anyReferenceWithCandidate;
		returnSameBinding;
		installInto: fylgja.



	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		mappingStubInstall;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: angular  root;
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



	installer := FylgjaRuleInstaller new
		             context: angular root;
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
FylgjaAbstractMigratorUI >> javaControllerPackage [

	^ java packages detect: [ :p | p name = 'Controller' ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> javaDaoPackage [

	^ java packages detect: [ :p | p name = 'DAO' ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> javaModelPackage [

	^ java packages detect: [ :p | p name = 'Model' ]
]

{ #category : #'as yet unclassified' }
FylgjaAbstractMigratorUI >> javaServicePackage [

	
	^ java packages detect: [ :p | p name = 'Service' ]
]

{ #category : #'as yet unclassified' }
FylgjaAbstractMigratorUI >> javaSqlBlob [

	^ (java catalog entities select: [ :a | 
		   (a isKindOf: MOClassType) and: [ a name = 'Blob' ] ]) first
]

{ #category : #'as yet unclassified' }
FylgjaAbstractMigratorUI >> javaString [

	^ (java entities select: [ :a | 
		   (a isKindOf: MOClass) and: [ a name = 'String' ] ]) first
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> logErrorFunction [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOInvocable) and: [ 
			  a name = 'LogError' ] ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> logErrorFunctionVariable [

	^ self logErrorFunction localVariables second
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> modelPackage [

	^ java packages detect: [ :p | p name = 'Model' ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> modelStubClass [

	^ (java packages detect: [ :p | p name = 'Model' ]) allTypes detect: [ 
		  :t | t name = 'Stub' ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> moduleCustomerOrders [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'CustomerOrders' ] ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> moduleDomainFunctionWrappers [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'DomainFunctionWrappers' ] ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> moduleInventory [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'Inventory' ] ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> modulePrivileges [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'Privileges' ] ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> modulePurchaseOrders [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'PurchaseOrders' ] ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> moduleReflective [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'Reflective' ] ]
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> moduleUtilities [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'Utilities' ] ]
]

{ #category : #'as yet unclassified' }
FylgjaAbstractMigratorUI >> openNorthwind [

	fylgja := FylgjaMigrationEngine new.
	northwind := MOJinDAMImporter northwind.
	angular := MOAngularLoader northwind.
	java := MOJavaMavenProjectLoader northwind.


	fylgja
		addModel: northwind;
		addModel: angular;
		addModel: java.
	fylgja := fylgja derivative.
	
]

{ #category : #initialization }
FylgjaAbstractMigratorUI >> recordsetWrapper [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOClass) and: [ a name = 'RecordsetWrapper' ] ]
]
