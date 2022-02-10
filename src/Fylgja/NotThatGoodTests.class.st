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
NotThatGoodTests >> recordsetWrapper [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: JinDAMClass) and: [ a name = 'RecordsetWrapper' ] ]
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

{ #category : #'as yet unclassified' }
NotThatGoodTests >> vbCrlf [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: JinDAMAttribute) and: [ a name = 'vbCrLf' ] ]
]
