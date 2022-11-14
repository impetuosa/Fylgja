Class {
	#name : #FylgjaMigrationLanguageAndLibrary,
	#superclass : #Object,
	#category : #'Fylgja-Experiments'
}

{ #category : #helper }
FylgjaMigrationLanguageAndLibrary class >> experimentPaperLibraryJava [

	| fylgja northwind java |
	fylgja := FylgjaMigrationEngine new.

	northwind := self paperSourceModel.
	java := self paperJava.

	fylgja
		addModel: northwind;
		addModel: java.

	self installJavaLanguageTx: java into: fylgja.
	self installMappings: northwind java: java using: fylgja.

	fylgja := fylgja derivative
		          installAllDerivativeModels;
		          yourself.


	^ fylgja
]

{ #category : #helper }
FylgjaMigrationLanguageAndLibrary class >> fylgja: fylgja map: aSource to: aTarget context: aContext mappings: aCollection [

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
FylgjaMigrationLanguageAndLibrary class >> fylgja: fylgja mapAll: aSourceCollection to: aTarget context: aContext mappings: aCollection [

	aSourceCollection do: [ :source | 
		self
			fylgja: fylgja
			map: source
			to: aTarget
			context: aContext
			mappings: aCollection ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibrary class >> installAdaptingRules: context into: fylgja [

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
FylgjaMigrationLanguageAndLibrary class >> installAssert: northwind java: java using: fylgja [

	"* Assert => this.assertTrue "

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Testing) invocableNamed: #Assert)
		to: ((java typeNamed: #Assert)
				 methodNamed: #assertEquals
				 parameters: { #String. #Object. #Object })
		context: java
		mappings: { 
				(1 -> 2).
				(2 -> 3).
				(3 -> 1) }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibrary class >> installConstantMappings: northwind java: java using: fylgja [

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #DateTime) memberNamed: #Now)
		to:
		((java typeNamed: #LocalDate) methodNamed: #now parameters: {  })
		context: java
		mappings: {  }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibrary class >> installConversion: northwind java: java using: fylgja [

	" * Val( string ) => Double.parseDouble( string )"

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Conversion) invocableNamed: #Val)
		to: ((java typeNamed: #Double)
				 methodNamed: #parseDouble
				 parameters: { #String })
		context: java
		mappings: { (1 -> 1) }.



	"* Str(expression) => expression.toString()"

	self
		fylgja: fylgja
		mapAll: ((northwind typeNamed: #Conversion) invocablesNamed: #Str)
		to: ((java typeNamed: #Objects)
				 methodNamed: #toString
				 parameters: { #Object })
		context: java
		mappings: { (1 -> 1) }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibrary class >> installDAOADOFunctionMappings: northwind java: java using: fylgja [

	"ADODB"

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Recordset library: #ADODB)
				 methodNamed: #MoveNext
				 parameters: {  })
		to:
		((java typeNamed: #ResultSet) methodNamed: #next parameters: {  })
		context: java
		mappings: {  }.

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Recordset library: #ADODB)
				 methodNamed: #MoveFirst
				 parameters: {  })
		to:
		((java typeNamed: #ResultSet) methodNamed: #first parameters: {  })
		context: java
		mappings: {  }.
	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Recordset library: #ADODB)
				 methodNamed: #MoveLast
				 parameters: {  })
		to:
		((java typeNamed: #ResultSet) methodNamed: #last parameters: {  })
		context: java
		mappings: {  }.


	self
		fylgja: fylgja
		map:
			((northwind typeNamed: #Recordset library: #ADODB) methodNamed:
				 #AddNew)
		to: ((java typeNamed: #ResultSet) methodNamed: #moveToInsertRow)
		context: java
		mappings: {  }.


	self
		fylgja: fylgja
		map:
			((northwind typeNamed: #Recordset library: #ADODB) methodNamed:
				 #Update)
		to:
		((java typeNamed: #ResultSet)
			 methodNamed: #insertRow
			 parameters: {  })
		context: java
		mappings: {  }.

	self
		fylgja: fylgja
		map:
			((northwind typeNamed: #Recordset library: #ADODB) methodNamed:
				 #Delete)
		to:
		((java typeNamed: #ResultSet)
			 methodNamed: #deleteRow
			 parameters: {  })
		context: java
		mappings: {  }.
	self
		fylgja: fylgja
		map:
		((northwind typeNamed: #Recordset library: #ADODB) methodNamed:
			 #Close)
		to:
		((java typeNamed: #ResultSet) methodNamed: #close parameters: {  })
		context: java
		mappings: {  }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibrary class >> installDAOFunctionMappings: northwind java: java using: fylgja [

	"DAO"

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Recordset library: #DAO)
				 methodNamed: #MoveNext
				 parameters: {  })
		to:
		((java typeNamed: #ResultSet) methodNamed: #next parameters: {  })
		context: java
		mappings: {  }.



	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Recordset library: #DAO)
				 methodNamed: #MoveFirst
				 parameters: {  })
		to:
		((java typeNamed: #ResultSet) methodNamed: #first parameters: {  })
		context: java
		mappings: {  }.


	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Recordset library: #DAO)
				 methodNamed: #MoveLast
				 parameters: {  })
		to:
		((java typeNamed: #ResultSet) methodNamed: #last parameters: {  })
		context: java
		mappings: {  }.

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Recordset library: #DAO)
				 methodNamed: #AddNew
				 parameters: {  })
		to: ((java typeNamed: #ResultSet)
				 methodNamed: #moveToInsertRow
				 parameters: {  })
		context: java
		mappings: {  }.


	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Recordset library: #DAO)
				 methodNamed: #Update
				 parameters: {  })
		to:
		((java typeNamed: #ResultSet)
			 methodNamed: #insertRow
			 parameters: {  })
		context: java
		mappings: {  }.

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Recordset library: #DAO)
				 methodNamed: #Delete
				 parameters: {  })
		to:
		((java typeNamed: #ResultSet)
			 methodNamed: #deleteRow
			 parameters: {  })
		context: java
		mappings: {  }.

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Recordset library: #DAO)
				 methodNamed: #Close
				 parameters: {  })
		to:
		((java typeNamed: #ResultSet) methodNamed: #close parameters: {  })
		context: java
		mappings: {  }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibrary class >> installDBFunctionMappings: northwind java: java using: fylgja [

	"DAO"
	self installDAOFunctionMappings: northwind java: java using: fylgja.
	"ADODB"
	self installDAOADOFunctionMappings: northwind java: java using: fylgja

]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibrary class >> installDate: northwind java: java using: fylgja [

	"* Date => LocalDate.now() "

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #DateTime) invocableNamed: #DateValue)
		to: ((java typeNamed: #LocalDate)
				 methodNamed: #parse
				 parameters: { #CharSequence })
		context: java
		mappings: { (1 -> 1) }.


	"* Date => LocalDate.now() "

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #DateTime)
				 invocableNamed: #Date
				 parameters: {  })
		to:
		((java typeNamed: #LocalDate) methodNamed: #now parameters: {  })
		context: java
		mappings: {  }.





	"* Year(date) => date.getYear() "

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #DateTime) invocableNamed: #Year)
		to:
		((java typeNamed: #LocalDate) methodNamed: #getYear parameters: {  })
		context: java
		mappings: { (1 -> #receiver) }.



	"* Day(date) => date.getDayOfMonth() "

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #DateTime) invocableNamed: #Day)
		to: ((java typeNamed: #LocalDate)
				 methodNamed: #getDayOfMonth
				 parameters: {  })
		context: java
		mappings: { (1 -> #receiver) }
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibrary class >> installFunctionMappings: northwind java: java using: fylgja [

	self installDBFunctionMappings: northwind java: java using: fylgja.

	self installConversion: northwind java: java using: fylgja.

	self installDate: northwind java: java using: fylgja.

	self installString: northwind java: java using: fylgja.

	self installObject: northwind java: java using: fylgja.

	self installAssert:  northwind java: java using: fylgja.
	
	
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibrary class >> installJavaLanguageTx: java into: fylgja [

	FylgjaRuleInstaller new
		topLevel;
		anyEntity;
		copy;
		installInto: fylgja.
	self installAdaptingRules: java root into: fylgja .
	
	
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

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibrary class >> installMappings: northwind java: java using: fylgja [

	self installTypeMappings: northwind java: java using: fylgja.
	self installFunctionMappings: northwind java: java using: fylgja.
	self installConstantMappings: northwind java: java using: fylgja
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibrary class >> installObject: northwind java: java using: fylgja [

	"* IsNull => Objects.isNull"

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Information) invocableNamed: #IsNull)
		to: ((java typeNamed: #Objects)
				 methodNamed: #isNull
				 parameters: { #Object })
		context: java
		mappings: { (1 -> 1) }
]

{ #category : #types }
FylgjaMigrationLanguageAndLibrary class >> installRuntimeTypeMappings: northwind java: java using: fylgja [

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
		        (#ulonglong -> #long) }.
	maps do: [ :m | 
		fylgja
			map: (northwind typeNamed: m key)
			to: (java typeNamed: m value)
			context: java ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationLanguageAndLibrary class >> installString: northwind java: java using: fylgja [

	"* InStr(from,source,thingToLookFor,[compare]) => source.indexOf(thingToLookFor, from)"

	self
		fylgja: fylgja
		map: ((northwind typeNamed: #Strings) invocableNamed: #InStr)
		to: ((java typeNamed: #String)
				 methodNamed: #indexOf
				 parameters: { #String. #int })
		context: java
		mappings: { 
				(2 -> #receiver).
				(1 -> 2).
				(3 -> 1) }.



	"* UCase(str) => str.toUpperCase()"

	self
		fylgja: fylgja
		mapAll: ((northwind typeNamed: #Strings) invocablesNamed: #UCase)
		to:
		((java typeNamed: #String)
			 methodNamed: #toUpperCase
			 parameters: {  })
		context: java
		mappings: { (1 -> #receiver) }.



	"* Trim(str) => str.trim()"

	self
		fylgja: fylgja
		mapAll: ((northwind typeNamed: #Strings) invocablesNamed: #Trim)
		to: ((java typeNamed: #String) methodNamed: #trim parameters: {  })
		context: java
		mappings: { (1 -> #receiver) }.


	"* Len(str) => str.length()"

	self
		fylgja: fylgja
		mapAll: ((northwind typeNamed: #Strings) invocablesNamed: #Len)
		to:
		((java typeNamed: #String) methodNamed: #length parameters: {  })
		context: java
		mappings: { (1 -> #receiver) }.


]

{ #category : #types }
FylgjaMigrationLanguageAndLibrary class >> installTypeMappings: northwind java: java using: fylgja [
	self installRuntimeTypeMappings: northwind java: java using: fylgja.
	self installVBATypeMappings: northwind java: java using: fylgja.
	fylgja
		map: (northwind typeNamed: #Connection library: #DAO)
		to: (java typeNamed: #Connection)
		context: java.
	
	fylgja
		map: (northwind aliasNamed: #Connection) "Adodb"
		to: (java typeNamed: #Connection)
		context: java.

	fylgja
		map: (northwind typeNamed: #Recordset  library: #DAO)
		to: (java typeNamed: #ResultSet)
		context: java.

		fylgja
		map: (northwind aliasNamed: #Recordset) "Adodb"
		to: (java typeNamed: #ResultSet)
		context: java.



]

{ #category : #types }
FylgjaMigrationLanguageAndLibrary class >> installVBATypeMappings: northwind java: java using: fylgja [

	| maps |
	maps := { 
		        (#_Collection -> #List).
		        (#Collection -> #List).
		        (#ErrObject -> #Exception) }.
	maps do: [ :m | 
		fylgja
			map: (northwind typeOrAliasNamed: m key library: #VBA)
			to: (java typeNamed: m value)
			context: java ]
]

{ #category : #helper }
FylgjaMigrationLanguageAndLibrary class >> northwindExperimentPaperLibraryJava [

	| fylgja northwind java |
	fylgja := FylgjaMigrationEngine new.
	
	northwind := MOJinDAMImporter northwind.
	java := MOJavaMavenProjectLoader northwind.


	fylgja
		addModel: northwind;
		addModel: java. 
		
	self installJavaLanguageTx: java into: fylgja. 
		
		
	fylgja := fylgja derivative
		          installAllDerivativeModels;
		          yourself.
		
		
	^ fylgja
]

{ #category : #helper }
FylgjaMigrationLanguageAndLibrary class >> paperJava [

	^ MOJavaMavenProjectLoader paperJava
]

{ #category : #helper }
FylgjaMigrationLanguageAndLibrary class >> paperSourceModel [

	^ MOJinDAMImporter paperSourceModel
]
