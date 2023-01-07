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
FylgjaJavaSpringRuleInstaller >> installAdaptingRules: context [

	FylgjaRuleInstaller new
		context: context;
		install: FylgjaSimpleRenameRule new into: fylgja.

	FylgjaRuleInstaller new
		context: context;
		install: FylgjaSimpleRenameWithStaticReceiverRule new into: fylgja.

	FylgjaRuleInstaller new
		context: context;
		install: FylgjaSimpleRenameWithReceiverMappedFromArgumentRule new
		into: fylgja.

	FylgjaRuleInstaller new
		context: context;
		install: FylgjaSimpleRenameWithSameClassReceiverRule new
		into: fylgja.

	"FylgjaRuleInstaller new
		context: context;
		install: FylgjaAutowrapLibraryElement new into: fylgja"
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installConstantMappings [

	[ 
	self
		map: ((northwind typeNamed: #DateTime) memberNamed: #Now)
		to:
		((java typeNamed: #LocalDate) methodNamed: #now parameters: {  })
		context: java
		mappings: {  } ]
		on: Error
		do: [  ]
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installConversion [

	" * Val( string ) => Double.parseDouble( string )"

	self
		map: ((northwind typeNamed: #Conversion) invocableNamed: #Val)
		to: ((java typeNamed: #Double)
				 methodNamed: #parseDouble
				 parameters: { #String })
		context: java
		mappings: { (1 -> 1) }.



	"* Str(expression) => expression.toString()"

	[ 
	self
		mapAll: ((northwind typeNamed: #Conversion) invocablesNamed: #Str)
		to: ((java typeNamed: #Objects)
				 methodNamed: #toString
				 parameters: { #Object })
		context: java
		mappings: { (1 -> 1) } ]
		on: Error
		do: [  ]
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installDate [

	"* Date => LocalDate.now() "

	[ 
	self
		map: ((northwind typeNamed: #DateTime) invocableNamed: #DateValue)
		to: ((java typeNamed: #LocalDate)
				 methodNamed: #parse
				 parameters: { #CharSequence })
		context: java
		mappings: { (1 -> 1) } ]
		on: Error
		do: [  ].

	"* Date => LocalDate.now() "
	[ 
	self
		map: ((northwind typeNamed: #DateTime)
				 invocableNamed: #Date
				 parameters: {  })
		to:
		((java typeNamed: #LocalDate) methodNamed: #now parameters: {  })
		context: java
		mappings: {  } ]
		on: Error
		do: [  ].




	"* Year(date) => date.getYear() "

	[ 
	self
		map: ((northwind typeNamed: #DateTime) invocableNamed: #Year)
		to:
		((java typeNamed: #LocalDate) methodNamed: #getYear parameters: {  })
		context: java
		mappings: { (1 -> #receiver) } ]
		on: Error
		do: [  ].


	"* Day(date) => date.getDayOfMonth() "

	[ 
	self
		map: ((northwind typeNamed: #DateTime) invocableNamed: #Day)
		to: ((java typeNamed: #LocalDate)
				 methodNamed: #getDayOfMonth
				 parameters: {  })
		context: java
		mappings: { (1 -> #receiver) } ]
		on: Error
		do: [  ]
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installFunctionMappings [

	self installConversion.
	self installDate.
	self installString.
	self installObject
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installJavaLanguageTx [


	self installAdaptingRules: java root .
	
	
	FylgjaRuleInstaller new
		context: java root;
		install: FylgjaDateLiteralToLocaleDateParse new into: fylgja.

	FylgjaRuleInstaller new
		context: java root;
		binaryOperator: #Is;
		replaceOperatorWith: #==;
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
		anyAlceModule;
		copyAsPublicClass;
		installInto: fylgja.
		
	FylgjaRuleInstaller new
		context: java root;
		anyTypeReferenceNamed: '#_TypeUndefined';
		copyAsTypesReferenceNamed: #Object;
		installInto: fylgja.


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

	FylgjaRuleInstaller new
		context: self javaControllerPackage;
		anySpringBootControllerClass;
		copyAsSpringBootControllerMethod;
		installInto: fylgja.


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
FylgjaJavaSpringRuleInstaller >> installMappings [

	self installTypeMappings.
	self installFunctionMappings.
	self installConstantMappings.
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installObject [

	[ 
	self
		map: ((northwind typeNamed: #Information) invocableNamed: #IsNull)
		to: ((java typeNamed: #Objects)
				 methodNamed: #isNull
				 parameters: { #Object })
		context: java
		mappings: { (1 -> 1) } ]
		on: Error
		do: [  ]
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installRules [

	super installRules.
	self installMappings.
	self installJavaLanguageTx.
	self installJavaSpring
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installRuntimeTypeMappings [

	| maps |
	maps := { 
		        (#BOOL -> #boolean).
		        (#BSTRString -> #String).
		        (#Boolean -> #boolean).
		        (#Byte -> #byte).
		        (#COMDispatchInterface -> #Object).
		        (#Currency -> #double).
		        (#Date -> #LocalDate).
		        (#Decimal -> #double).
		        (#Double -> #double).
		        (#Err -> #Exception).
		        (#Integer -> #int).
		        (#Long -> #long).
		        (#LongLong -> #long).
		        (#Object -> #Object).
		        (#Single -> #float).
		        (#String -> #String).
		        (#USERDEFINED -> #Object).
		        (#VOID -> #void).
		        (#Void -> #void).
		        (#Variant -> #Object).
		        (#Win32Variant -> #Object).
		        (#Win32WideString -> #String).
		        (#float -> #float).
		        (#int -> #int).
		        (#int16 -> #short).
		        (#uint16 -> #short).
		        (#int32 -> #int).
		        (#uint32 -> #int).
		        (#ubyte -> #byte).
		        (#uint -> #int).
		        (#ulong -> #long).
		        (#ulonglong -> #long).
		        (#dbMemo -> #String).
		        (#dbText -> #String).
		        (#dbLong -> #long).
		        (#dbAttachment -> #Blob) }.
	maps do: [ :m | 
		[ 
		fylgja
			map: (northwind typeNamed: m key)
			to: (java typeNamed: m value)
			context: java ]
			on: Error
			do: [ self halt ] ]
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installString [

	"* InStr(from,source,thingToLookFor,[compare]) => source.indexOf(thingToLookFor, from)"

	[ 
	self
		map: ((northwind typeNamed: #Strings) invocableNamed: #InStr)
		to: ((java typeNamed: #String)
				 methodNamed: #indexOf
				 parameters: { #String. #int })
		context: java
		mappings: { 
				(2 -> #receiver).
				(1 -> 2).
				(3 -> 1) } ]
		on: Error
		do: [  ].



	"* UCase(str) => str.toUpperCase()"

	[ 
	self
		mapAll: ((northwind typeNamed: #Strings) invocablesNamed: #UCase)
		to:
		((java typeNamed: #String)
			 methodNamed: #toUpperCase
			 parameters: {  })
		context: java
		mappings: { (1 -> #receiver) } ]
		on: Error
		do: [  ].



	"* Trim(str) => str.trim()"

	[ 
	self
		mapAll: ((northwind typeNamed: #Strings) invocablesNamed: #Trim)
		to: ((java typeNamed: #String) methodNamed: #trim parameters: {  })
		context: java
		mappings: { (1 -> #receiver) } ]
		on: Error
		do: [  ].


	"* Len(str) => str.length()"

	[ 
	self
		mapAll: ((northwind typeNamed: #Strings) invocablesNamed: #Len)
		to:
		((java typeNamed: #String) methodNamed: #length parameters: {  })
		context: java
		mappings: { (1 -> #receiver) } ]
		on: Error
		do: [  ]
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installTypeMappings [

	self installVBATypeMappings.
	self installRuntimeTypeMappings
]

{ #category : #general }
FylgjaJavaSpringRuleInstaller >> installVBATypeMappings [

	| maps |
	maps := { 
		        (#_Collection -> #List).
		        (#Collection -> #List).
		        (#ErrObject -> #Exception) }.
	maps do: [ :m | 
		[ 
		fylgja
			map: (northwind typeOrAliasNamed: m key library: #VBA)
			to: (java typeNamed: m value)
			context: java ]
			on: Error
			do: [  ] ]
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
