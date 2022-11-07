Class {
	#name : #FylgjaMigrationLanguageAndLibraryPharo,
	#superclass : #Object,
	#classInstVars : [
		'paperPharo'
	],
	#category : #'Fylgja-Experiments'
}

{ #category : #helper }
FylgjaMigrationLanguageAndLibraryPharo class >> experimentPaperLibraryPharo [

	| fylgja northwind pharo |
	fylgja := FylgjaMigrationEngine new.

	northwind := self paperSourceModel.
	pharo := self paperPharo.

	fylgja
		addModel: northwind;
		addModel: pharo.

	self installPharoLanguageTx: pharo into: fylgja.
	self installMappings: northwind pharo: pharo using: fylgja.

	fylgja := fylgja derivative
		          installAllDerivativeModels;
		          yourself.


	^ fylgja
]

{ #category : #helper }
FylgjaMigrationLanguageAndLibraryPharo class >> fylgja: fylgja map: aSource to: aTarget context: aContext mappings: aCollection [

	| mappings |
	mappings := Dictionary new.

	aCollection do: [ :map | 
		| sourceId targetId |
		sourceId := map key.
		targetId := map value.
		targetId isNumber
			ifFalse: [ 
			mappings at: targetId put: (aSource parameters at: sourceId) ]
			ifTrue: [ 
				mappings
					at: (aTarget parameters at: targetId)
					put: (aSource parameters at: sourceId) ] ].
	^ fylgja
		  map: aSource
		  to: aTarget
		  context: aContext
		  mapping: mappings
]

{ #category : #helper }
FylgjaMigrationLanguageAndLibraryPharo class >> fylgja: fylgja mapAll: aSourceCollection to: aTarget context: aContext mappings: aCollection [

	aSourceCollection do: [ :source | 
		self
			fylgja: fylgja
			map: source
			to: aTarget
			context: aContext
			mappings: aCollection ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibraryPharo class >> installAdaptingRules: context into: fylgja [

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

	FylgjaRuleInstaller new
		context: context;
		install: FylgjaAutowrapLibraryElement new into: fylgja
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibraryPharo class >> installAssert: northwind pharo: pharo using: fylgja [

	"* Assert => this.assertTrue "

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Testing) invocableNamed: #Assert)
		to: ((pharo typeNamed: #TestAsserter) methodNamed: #assert:equals:)
		context: pharo
		mappings: { 
				(1 -> 1).
				(2 -> 2) }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibraryPharo class >> installConstantMappings: northwind pharo: pharo using: fylgja [

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #DateTime) memberNamed: #Now)
		to: ((pharo typeNamed: #DateAndTime) metaclass
				 methodNamed: #now
				 parameters: {  })
		context: pharo
		mappings: {  }.

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Constants library:#VBA) memberNamed: #vbCrLf)
		to: ((pharo typeNamed: #String) metaclass
				 methodNamed: #crlf
				 parameters: {  })
		context: pharo
		mappings: {  }.


	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Constants library:#VBA) memberNamed: #vbNullChar)
		to: ((pharo typeNamed: #Character) metaclass
				 methodNamed: #null
				 parameters: {  })
		context: pharo
		mappings: {  }.

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Constants library:#VBA) memberNamed: #vbNullString)
		to: ((pharo typeNamed: #String) metaclass
				 methodNamed: #empty
				 parameters: {  })
		context: pharo
		mappings: {  }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibraryPharo class >> installConversion: northwind pharo: pharo using: fylgja [

	" * Val( string ) => Double.parseDouble( string )"

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Conversion) invocableNamed: #Val)
		to: ((pharo typeNamed: #Number) metaclass  methodNamed: #readFrom:)
		context: pharo
		mappings: { (1 -> 1) }.



	"* Str(expression) => expression.toString()"

	self
		fylgja: fylgja
		mapAll: ((northwind typeNamed: #Conversion) invocablesNamed: #Str)
		to: ((pharo typeNamed: #Object) methodNamed: #asString)
		context: pharo
		mappings: { (1 -> #receiver) }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibraryPharo class >> installDate: northwind pharo: pharo using: fylgja [

	"* Date => LocalDate.now() "

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #DateTime) invocableNamed: #DateValue)
		to: ((pharo typeNamed: #String) methodNamed: #asDate)
		context: pharo
		mappings: { (1 -> #receiver) }.


	"* Date => LocalDate.now() "

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #DateTime)
				 invocableNamed: #Date
				 parameters: {  })
		to: ((pharo typeNamed: #DateAndTime) metaclass methodNamed: #now)
		context: pharo
		mappings: {  }.


	"* Year(date) => date.getYear() "
	self
		fylgja: fylgja
		map: ((northwind typeNamed: #DateTime) invocableNamed: #Year)
		to:
		((pharo typeNamed: #DateAndTime) methodNamed: #year parameters: {  })
		context: pharo
		mappings: { (1 -> #receiver) }.

	"* Day(date) => date.getDayOfMonth() "
	self
		fylgja: fylgja
		map: ((northwind typeNamed: #DateTime) invocableNamed: #Day)
		to: ((pharo typeNamed: #DateAndTime)
				 methodNamed: #dayOfMonth
				 parameters: {  })
		context: pharo
		mappings: { (1 -> #receiver) }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibraryPharo class >> installMappings: northwind pharo: pharo using: fylgja [

	self installAssert: northwind pharo: pharo using: fylgja.
	self installConstantMappings: northwind pharo: pharo using: fylgja.
	self installConversion: northwind pharo: pharo using: fylgja.

	self installDate: northwind pharo: pharo using: fylgja.
	self installObject: northwind java: pharo using: fylgja.

	self installOthers: northwind pharo: pharo using: fylgja.
	self installString: northwind pharo: pharo using: fylgja.
	self installTypeMappings: northwind pharo: pharo using: fylgja
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibraryPharo class >> installObject: northwind java: pharo using: fylgja [


	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Information) invocableNamed: #IsNull)
		to: ((pharo typeNamed: #ProtoObject) methodNamed: #isNil)
		context: pharo
		mappings: { (1 -> #receiver) }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibraryPharo class >> installOthers: northwind pharo: pharo using: fylgja [

	


		" * Iif(condition, ifTrue, ifFalse,  ) => condition ifTrue:ifFalse "

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Information) invocableNamed: #TypeName)
		to:
		((pharo typeNamed: #Object) methodNamed: #className)
		context: pharo
		mappings: { 
				(1 -> #receiver).
 }.


	" * Iif(condition, ifTrue, ifFalse,  ) => condition ifTrue:ifFalse "

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Interaction) invocableNamed: #IIf)
		to:
		((pharo typeNamed: #Boolean) methodNamed: #ifTrue:ifFalse:)
		context: pharo
		mappings: { 
				(1 -> #receiver).
				(2 -> 1).
				(3 -> 2) }.







	" * Chr( 13 ) => Character value: 13 "

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Strings) invocableNamed: #Chr  returns: #BSTRString )
		to: ((pharo typeNamed: #Character) metaclass methodNamed: #value:)
		context: pharo
		mappings: { (1 -> 1) }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibraryPharo class >> installPharoLanguageTx: pharo into: fylgja [

	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.

	self installAdaptingRules: pharo root into: fylgja.

	FylgjaRuleInstaller new
		context: pharo root;
		binaryOperator: #Is;
		replaceOperatorWith: #=;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: pharo root;
		binaryOperator: #&;
		replaceOperatorWith: #,;
		installInto: fylgja.

	FylgjaRuleInstaller new
		context: pharo root;
		anyAlceModule;
		copyAsStPublicClass;
		installInto: fylgja.


	" By default when going to java "
	FylgjaRuleInstaller new
		context: pharo root;
		anyModelEntityOfTypesWhenGoingClass: { 
				MOVariableAccessor.
				MOAttributeAccessor.
				MOClassFunction.
				MOClassProcedure.
				MOFunction.
				MOProcedure };
		copyAsStMethod;
		installInto: fylgja.
	" By default when going to java "

	FylgjaRuleInstaller new
		context: pharo root;
		anyModelEntityOfTypesWhenGoingClass: { 
				MOGlobalVariable.
				MOGlobalConstant };
		copyAsAttribute;
		installInto: fylgja
]

{ #category : #types }
FylgjaMigrationLanguageAndLibraryPharo class >> installRuntimeTypeMappings: northwind pharo: pharo using: fylgja [
	| maps |


	maps := { 
		        (#BOOL -> #Boolean).
		        (#BSTRString -> #String).
		        (#Boolean -> #Boolean).
		        (#Byte -> #SmallInteger).
		        (#COMDispatchInterface -> #Object).
		        (#Currency -> #Float).
		        (#Date -> #DateAndTime).
		        (#Decimal -> #Float).
		        (#Double -> #Float).
		        (#Err -> #Exception).
		        (#Integer -> #Integer).
		        (#Long -> #Integer).
		        (#LongLong -> #Integer).
		        (#Object -> #Object).
		        (#Single -> #Float).
		        (#String -> #String).
		        (#USERDEFINED -> #Object).
		        (#Variant -> #Object).
		        (#Win32Variant -> #Object).
		        (#Win32WideString -> #String).
		        (#float -> #Float).
		        (#int -> #Integer).
		        (#int16 -> #SmallInteger).
		        (#uint16 -> #SmallInteger).
		        (#int32 -> #Integer).
		        (#uint32 -> #Integer).
		        (#ubyte -> #SmallInteger).
		        (#uint -> #Integer).
		        (#ulong -> #Integer).
		        (#ulonglong -> #Integer) }.
	maps do: [ :m | 
		fylgja
			map: (northwind typeNamed: m key )
			to: (pharo typeNamed: m value)
			context: pharo ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibraryPharo class >> installString: northwind pharo: pharo using: fylgja [

	"* InStr(from,source,thingToLookFor,[compare]) => source.indexOf(thingToLookFor, from)"

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Strings) invocableNamed: #InStr)
		to: ((pharo typeNamed: #SequenceableCollection) methodNamed:
				 #indexOfSubCollection:startingAt:)
		context: pharo
		mappings: { 
				(2 -> #receiver).
				(1 -> 2).
				(3 -> 1) }.

	"* UCase(str) => str.toUpperCase()"

	self
		fylgja: fylgja
		mapAll: ((northwind typeNamed: #Strings) invocablesNamed: #UCase)
		to:
		((pharo typeNamed: #String)
			 methodNamed: #asUppercase
			 parameters: {  })
		context: pharo
		mappings: { (1 -> #receiver) }.



	"* Trim(str) => str.trim()"

	self
		fylgja: fylgja
		mapAll: ((northwind typeNamed: #Strings) invocablesNamed: #Trim)
		to:
		((pharo typeNamed: #String) methodNamed: #trimBoth parameters: {  })
		context: pharo
		mappings: { (1 -> #receiver) }.


	"* Len(str) => str.length()"

	self
		fylgja: fylgja
		mapAll: ((northwind typeNamed: #Strings) invocablesNamed: #Len)
		to: ((pharo typeNamed: #ArrayedCollection) methodNamed: #size parameters: {  })
		context: pharo
		mappings: { (1 -> #receiver) }
]

{ #category : #types }
FylgjaMigrationLanguageAndLibraryPharo class >> installTypeMappings: northwind pharo: pharo using: fylgja [

	self installRuntimeTypeMappings: northwind pharo: pharo using: fylgja.
	self installVBATypeMappings: northwind pharo: pharo using: fylgja.
	
]

{ #category : #types }
FylgjaMigrationLanguageAndLibraryPharo class >> installVBATypeMappings: northwind pharo: pharo using: fylgja [

	
	| maps |
	maps := { 
		        (#_Collection -> #OrderedCollection).
		        (#Collection -> #OrderedCollection).
		        (#ErrObject -> #Error) }.
	maps do: [ :m | 
		fylgja
			map: (northwind typeOrAliasNamed: m key library: #VBA)
			to: (pharo typeNamed: m value)
			context: pharo ]
]

{ #category : #helper }
FylgjaMigrationLanguageAndLibraryPharo class >> loadPaperPharo [

	| phary |
	paperPharo := MOModel newPharo.
	paperPharo name: #PaperPharo.
	phary := MORBPharoImporter new.
	phary writer: paperPharo writer.
	phary importPackages:
		({ 'Kernel-Objects'. 'Kernel-Numbers'. 'Kernel-Chronology'.
		 'Kernel-BasicObjects'. 'Kernel-Exceptions'. #'Collections-Abstract'.
		 'Collections-Sequenceable'. 'Collections-Unordered'.
		 'Collections-Strings'. 'SUnit-Core'. 'Garage'. #PaperPharo } 
			 collect: #asPackageOrTag).
	^ paperPharo
]

{ #category : #helper }
FylgjaMigrationLanguageAndLibraryPharo class >> paperPharo [

	^ paperPharo ifNil: [ paperPharo := self loadPaperPharo ] 
]

{ #category : #helper }
FylgjaMigrationLanguageAndLibraryPharo class >> paperSourceModel [

	^ MOJinDAMImporter paperSourceModel
]
