Class {
	#name : #FylgjaMigrationUIController,
	#superclass : #Object,
	#instVars : [
		'fylgja',
		'origin',
		'destinations',
		'interestedInSelection',
		'interestedInLogging',
		'lookupContext'
	],
	#category : #'Fylgja-UI'
}

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController class >> northwindController [

	| fylgja northwind java angular |
	fylgja := FylgjaMigrationEngine new.
	northwind := MOJinDAMImporter northwind.
	angular := MOAngularLoader northwind.
	java := MOJavaMavenProjectLoader northwind.


	fylgja
		addModel: northwind;
		addModel: angular;
		addModel: java.
	self ruleInstallers do: [ :a | 
		a
			fylgja: fylgja;
			northwind: northwind;
			java: java;
			angular: angular;
			installRules ].
	fylgja := fylgja derivative.
	^ self new
		  fylgja: fylgja;
		  origin: (fylgja derivativeModelFor: northwind);
		  destinations: { 
				  (fylgja derivativeModelFor: java).
				  (fylgja derivativeModelFor: angular) };
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController class >> ruleInstallers [

	^ FylgjaNorthwindRuleInstaller allSubclasses collect: #new
]

{ #category : #accessing }
FylgjaMigrationUIController >> autoBind: aCollection [

	self doOrLog: [ 
		fylgja forceMapReferences: aCollection.
		self logOperation: #AutoBind ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> destinations [
	^ destinations
]

{ #category : #accessing }
FylgjaMigrationUIController >> destinations: aCollection [

	destinations := aCollection
]

{ #category : #accessing }
FylgjaMigrationUIController >> doOrLog: aFullBlockClosure forOperation: aOperationName ifFailReturn: aBlock [

	^ [ aFullBlockClosure value ]
		  on: Error
		  do: [ :e | 
			  self logError: e operation: aOperationName.
			  self isDebugging
				  ifTrue: [ e pass ]
				  ifFalse: [ aBlock value ] ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> fylgja: aFylgjaDerivativeModel [ 
	fylgja := aFylgjaDerivativeModel
]

{ #category : #accessing }
FylgjaMigrationUIController >> informSelection: aSelection from: aWidget [

	lookupContext := nil.
	self interestedInSelection
		reject: [ :subscriber | subscriber first = aWidget ]
		thenDo: [ :subscriber | 
			subscriber first ifNotNil: [ :f | f updateSelectionTo: aSelection ] ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> initialize [

	super initialize.
	interestedInSelection := OrderedCollection new.
	interestedInLogging := OrderedCollection new
]

{ #category : #accessing }
FylgjaMigrationUIController >> interestedInLogging [

	^ interestedInLogging := interestedInLogging reject: [ :a | 
		                         a first isNil ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> interestedInSelection [

	^ interestedInSelection := interestedInSelection reject: [ :a | 
		                           a first isNil ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> isDebugging [
	 ^ true
]

{ #category : #accessing }
FylgjaMigrationUIController >> logError: anError operation: aOperationName [

	| entry |
	entry := FylgjaErrorEntry new
		         operation: aOperationName;
		         exception: anError;
		         yourself.
	self interestedInLogging do: [ :subscriber | 
		subscriber first ifNotNil: [ :f | f log: entry ] ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> logSuccess: result operation: anOperationName [

	| entry |
	entry := FylgjaSuccessEntry new
		         operation: anOperationName;
		         messageText: result printString;
		         yourself.
	self interestedInLogging do: [ :subscriber | 
		subscriber first ifNotNil: [ :f | f log: entry ] ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> map: anEntity to: other context: context informing: aWidget [

	| result |
	^ self
		  doOrLog: [ 
			  self
				  assert: anEntity isNotNil
				  description: ' Cannot resolve provenance entity .'.
			  self
				  assert: other isNotNil
				  description: ' Cannot resolve destination .'.
			  result := fylgja map: anEntity to: other context: context.
			  self logSuccess: result operation: #Map.
			  aWidget ruleHasBeenAppliedSuccessfully.
			  result ]
		  forOperation: #Map
		  ifFailReturn: [ nil ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> mrsFor: aDeclaration [

	lookupContext ifNotNil: [ ^ lookupContext ].
	^ self
		  doOrLog: [ lookupContext := fylgja mrsFor: aDeclaration ]
		  forOperation: #Lookup
		  ifFailReturn: [ nil ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> origin [
	^ origin
]

{ #category : #accessing }
FylgjaMigrationUIController >> origin: aMOModelDerivative [

	origin := aMOModelDerivative
]

{ #category : #accessing }
FylgjaMigrationUIController >> produce: aProvenance into: aDestination informing: aWidget [

	| result |
	^ self
		  doOrLog: [ 
			  self
				  assert: aProvenance isNotNil
				  description: ' Cannot resolve provenance entity .'.
			  self
				  assert: aDestination isNotNil
				  description: ' Cannot resolve destination .'.
			  result := fylgja produce: aProvenance into: aDestination.
			  self logSuccess: result operation: #Produce.
			  aWidget ruleHasBeenAppliedSuccessfully.
			  result ]
		  forOperation: #Produce
		  ifFailReturn: [ nil ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> registerForEntitySelected: aWidget [

	self interestedInSelection add: aWidget asWeakReference
]

{ #category : #accessing }
FylgjaMigrationUIController >> registerForEventLogging: aLoggingWidget [

	self interestedInLogging add: aLoggingWidget asWeakReference
]

{ #category : #accessing }
FylgjaMigrationUIController >> stubsFor: aDeclaration [

	^ FylgjaReachableStubs new stubsFor: aDeclaration
]
