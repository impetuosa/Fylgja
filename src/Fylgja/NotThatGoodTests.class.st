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

{ #category : #'as yet unclassified' }
NotThatGoodTests >> accessDbAttachment [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOPrimitiveType) and: [ a name = #dbAttachment ] ]
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> accessDbMemoType [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOPrimitiveType) and: [ a name = #dbMemo ] ]
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> accessDbTextType [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOPrimitiveType) and: [ a name = #dbText ] ]
]

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

{ #category : #asserting }
NotThatGoodTests >> assertAllReferencesHaveCandidate: aFylgjaDerivationResult [

	self assert:
		((self allReferencesFrom: aFylgjaDerivationResult) select: [ :e | 
			 e candidate isNil and: [ e isFylgjaMissingCandidateStub not  ] ]) isEmpty
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> assertProducedElementsAreEquivalent [

	self assert: (fylgja traces reject: [ :a | 
			 a first to allContainments size = a last allContainments size and: [ 
				 a first to allReferences size = a last allReferences size and: [ 
					 a first to allExpressions size = a last allExpressions size ] ] ])
			isEmpty
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> assertProducedElementsAreEquivalentBut: aBlock [

	self assert: ((fylgja traces reject: [ :a | 
			  a first to allContainments size = a last allContainments size 
				  and: [ 
					  a first to allReferences size = a last allReferences size and: [ 
						  a first to allExpressions size = a last allExpressions size ] ] ]) 
			 reject: aBlock) isEmpty
]

{ #category : #initialization }
NotThatGoodTests >> assertTracedClasses [

	self assert: (fylgja traces reject: [ :a | 
			 a first to class = a last class or: [ 
				 a last isFylgjaStub and: [ a last provenance = a first ] ] ])
			isEmpty
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
NotThatGoodTests >> employeeDetails [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOAlceForm) and: [ a name = 'Form_Employee_Details' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> errorHandlingClass [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOClass) and: [ a name = 'ErrorHandling' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> javaControllerPackage [

	^ java packages detect: [ :p | p name = 'Controller' ]
]

{ #category : #initialization }
NotThatGoodTests >> javaDaoPackage [

	^ java packages detect: [ :p | p name = 'DAO' ]
]

{ #category : #initialization }
NotThatGoodTests >> javaModelPackage [

	^ java packages detect: [ :p | p name = 'Model' ]
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> javaServicePackage [

	
	^ java packages detect: [ :p | p name = 'Service' ]
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> javaSqlBlob [

	^ (java catalog entities select: [ :a | 
		   (a isKindOf: MOClassType) and: [ a name = 'Blob' ] ]) first
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> javaString [

	^ (java entities select: [ :a | 
		   (a isKindOf: MOClass) and: [ a name = 'String' ] ]) first
]

{ #category : #initialization }
NotThatGoodTests >> logErrorFunction [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOInvocable) and: [ 
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
NotThatGoodTests >> moduleCustomerOrders [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'CustomerOrders' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> moduleDomainFunctionWrappers [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'DomainFunctionWrappers' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> moduleInventory [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'Inventory' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> modulePrivileges [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'Privileges' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> modulePurchaseOrders [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'PurchaseOrders' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> moduleReflective [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'Reflective' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> moduleUtilities [


	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOModule) and: [ a name = 'Utilities' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> recordsetWrapper [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOClass) and: [ a name = 'RecordsetWrapper' ] ]
]

{ #category : #initialization }
NotThatGoodTests >> runCaseManaged [ 
	^ self runCase 
]

{ #category : #initialization }
NotThatGoodTests >> setUp [

	super setUp.

	fylgja := FylgjaMigrationEngine new.
	northwind := MOJinDAMImporter northwind . 
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

{ #category : #'as yet unclassified' }
NotThatGoodTests >> tsBlob [

	^ self tsString 
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> tsString [

	^ (angular entities detect: [ :a | 
		   a isType and: [ a name = 'string' ] ]) 
]

{ #category : #'as yet unclassified' }
NotThatGoodTests >> vbCrlf [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOGlobalVariable ) and: [ a name = 'vbCrLf' ] ]
]
