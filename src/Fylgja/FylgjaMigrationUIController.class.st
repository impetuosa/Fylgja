Class {
	#name : #FylgjaMigrationUIController,
	#superclass : #Object,
	#instVars : [
		'fylgja',
		'origin',
		'destinations',
		'interestedInSelection',
		'interestedInLogging',
		'lookupContext',
		'projectName'
	],
	#category : #'Fylgja-UI'
}

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController class >> egrcController [

	| fylgja northwind java angular |
	fylgja := FylgjaMigrationEngine new.
	northwind := MOJinDAMImporter egrc.
	angular := MOAngularLoader egrc.
	java := MOJavaMavenProjectLoader egrc.

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
	fylgja := fylgja derivative
		          installAllDerivativeModels;
		          yourself.
	^ self new
		  fylgja: fylgja;
		  origin: northwind;
		  destinations: { 
				  java.
				  angular };
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController class >> fromFylgja: fylgja [

	| northwind java |
	northwind := fylgja models detect: [ :m | 
		             m language isMicrosoftAccess ].
	java := fylgja models detect: [ :m | 
		        m language isMicrosoftAccess not ].
	^ self new
		  fylgja: fylgja;
		  origin: northwind model;
		  destinations: { java model };
		  yourself
]

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
	fylgja := fylgja derivative
		          installAllDerivativeModels;
		          yourself.
	^ self new
		  fylgja: fylgja;
		  origin: northwind;
		  destinations: { 
				  java.
				  angular };
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController class >> northwindControllerPaper [

	| fylgja northwind java |
	fylgja := FylgjaMigrationLanguageAndLibrary
		          northwindExperimentPaperLibraryJava.
	northwind := fylgja models second.
	java := fylgja models first.
	^ self new
		  fylgja: fylgja;
		  origin: northwind model ;
		  destinations: { java model };
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController class >> ruleInstallers [

	^ FylgjaNorthwindRuleInstaller allSubclasses collect: #new
]

{ #category : #accessing }
FylgjaMigrationUIController >> applyCommand: aCommand informing: aWidget do: aBlock [

	| result |
	^ self
		  transactionalDoOrLog: [ 
			  result := aBlock value.
			  self logSuccess: result operation: aCommand name.
			  aWidget ruleHasBeenAppliedSuccessfully.
			  result ]
		  forOperation: #UICommand
		  ifFailReturn: [ nil ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> autoBind: aCollection [ 
	^ self
		  doOrLog: [ 
			  self fylgja forceMapReferences: aCollection.
			  self logSuccess: #Succeed operation: #AutoBind ]
		  forOperation: #AutoBind
		  ifFailReturn: [ nil ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController >> buildMappingFor: aMOProcedure and: aMOMethod informing: aMoxingBundle [

	| mapping |
	aMOProcedure allContainments select: [ :a | a isDeclaration ].
	aMOMethod allContainments select: [ :a | a isDeclaration ].
	mapping := MoxingMapping new
		           application: aMoxingBundle application;
		           source: aMOProcedure target: aMOMethod.
	mapping openModal ifFalse: [ self error: 'Cancelled' ].
	^ mapping mapping
]

{ #category : #accessing }
FylgjaMigrationUIController >> chooseAndMap: anEntity to: other context: context informing: aWidget [

	^ (UIManager default
		   chooseFrom: #( 'Simple Mapping' 'Map entity and children' )
		   values: { 
				   [ self fylgja map: anEntity to: other context: context ].
				   [ 
				   self fylgja
					   map: anEntity
					   to: other
					   context: context
					   mapping:
					   (self buildMappingFor: anEntity and: other informing: aWidget) ] }
		   title: 'Fylgja') ifNotNil: [ :block | block value ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> createCheckpointFor: aWidget [

	self
		doOrLog: [ 
			self flag: #Comment.
			"should be using: self privateCreateCheckpoint."

			fylgja push: (fylgja top derivative
					 installAllDerivativeModels;
					 yourself).
			self
				logSuccess:
				'Successfull checkpoint. Version: ' , fylgja size asString
				operation: #CheckPoint.
			aWidget ruleHasBeenAppliedSuccessfully ]
		forOperation: #CheckPoint
		ifFailReturn: [ nil ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> destinations [

	^ destinations collect: [ :original | 
		  self fylgja derivativeModels detect: [ :derivative | 
			  derivative isDerivedFrom: original ] ]
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

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController >> dropAllChangesWith: aWidget [

	| fylgjaModel stackCopy |
	self
		doOrLog: [ 
			stackCopy := fylgja shallowCopy.
			fylgjaModel := stackCopy last originalModel derivative.
			fylgjaModel installAllDerivativeModels.
			stackCopy do: [ :a | a finalizeFylgja ].
			stackCopy removeAll.
			stackCopy push: fylgjaModel.
			fylgja := stackCopy.
			self
				logSuccess:
				'Successfull drop all changes. Version: ' , fylgja size asString
				operation: #DropAllChanges.
			aWidget ruleHasBeenAppliedSuccessfully ]
		forOperation: #DropAllChanges
		ifFailReturn: [ nil ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController >> exportDraft: aFileReference informTo: aWidget [

	| result |
	^ self
		  doOrLog: [ 
			  self
				  assert: aFileReference isDirectory
				  description: 'Directory was expected'.
			  result := self destinations collect: [ :a | 
				            a exportAsDraftIntoDirectory:
					            (aFileReference / a name) ensureCreateDirectory ].

			  self logSuccess: result operation: #ExportAsDraft.
			  aWidget ruleHasBeenAppliedSuccessfully.
			  result ]
		  forOperation: #ExportAsDraft
		  ifFailReturn: [ nil ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController >> finalizeFylgja [

	fylgja do: #finalizeFylgja.
	fylgja do: [ :f | f becomeForward: {  } ].
	fylgja removeAll.
	origin := nil.
	destinations := nil.
	(interestedInSelection collect: #first thenReject: #isNil) do: [ :w | 
		w withWidgetDo: #delete ].

	(interestedInLogging collect: #first thenReject: #isNil) do: [ :w | 
		w withWidgetDo: #delete ].
	(interestedInSelection , interestedInLogging
		 collect: #first
		 thenReject: #isNil) do: [ :e | e becomeForward: {  } ].
	interestedInSelection removeAll.
	interestedInLogging removeAll
]

{ #category : #accessing }
FylgjaMigrationUIController >> fylgja [

	^ fylgja top
]

{ #category : #accessing }
FylgjaMigrationUIController >> fylgja: aFylgjaDerivativeModel [

	self
		assert: fylgja isNil
		description: 'Fylgja can be set only once !'.
	fylgja := Stack new.
	fylgja push: aFylgjaDerivativeModel
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
FylgjaMigrationUIController >> logWarning: result operation: anOperationName [

	| entry |
	entry := FylgjaWarningEntry new
		         operation: anOperationName;
		         messageText: result printString;
		         yourself.
	self interestedInLogging do: [ :subscriber | 
		subscriber first ifNotNil: [ :f | f log: entry ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController >> lookupAllRulesForProducing: aProvenanceEntity toContext: aDestinationContext [

	| elementRelation destinationContextRelation destinationModel writer |
	elementRelation := self fylgja readEntitysContextualizingRelation:
		                   aProvenanceEntity.
	destinationContextRelation := self fylgja 
		                              readEntitysContextualizingRelation:
		                              aDestinationContext.
	destinationModel := self fylgja selectDerivativeModelFor:
		                    aDestinationContext.

	writer := destinationModel writer
		          updaterFor: destinationContextRelation
		          with: elementRelation.

	^ (self fylgja
		   lookupContextFor: elementRelation
		   toContext: destinationContextRelation
		   model: destinationModel)
		  lookupAllRulesForProducing: elementRelation
		  with: writer
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController >> lookupContextFor: aProvenanceEntity toContext: aDestinationContext [

	| elementRelation destinationContextRelation destinationModel |
	elementRelation := self fylgja readEntitysContextualizingRelation:
		                   aProvenanceEntity.
	destinationContextRelation := self fylgja 
		                              readEntitysContextualizingRelation:
		                              aDestinationContext.
	destinationModel := self fylgja selectDerivativeModelFor:
		                    aDestinationContext.
	^ self fylgja
		  lookupContextFor: elementRelation
		  toContext: destinationContextRelation
		  model: destinationModel
]

{ #category : #accessing }
FylgjaMigrationUIController >> map: anEntity to: other context: context [

	^ (UIManager default
		   chooseFrom: #( 'Simple Mapping' 'Map entity and children' )
		   values: { 
				   [ self fylgja map: anEntity to: other context: context ].
				   [ 
				   self fylgja
					   map: anEntity
					   to: other
					   context: context
					   mapping: (self buildMappingFor: anEntity and: other) ] }
		   title: 'Fylgja') ifNotNil: [ :block | block value ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> map: anEntity to: other context: context informing: aWidget [

	| result |
	^ self
		  transactionalDoOrLog: [ 
			  self
				  assert: anEntity isNotNil
				  description: ' Cannot resolve provenance entity .'.
			  self
				  assert: other isNotNil
				  description: ' Cannot resolve destination .'.
			  result := self chooseAndMap: anEntity to: other context: context informing:aWidget.
			  self logSuccess: result operation: #Map.
			  aWidget ruleHasBeenAppliedSuccessfully.
			  result ]
		  forOperation: #Map
		  ifFailReturn: [ nil ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> mrsFor: aDeclaration [
	^ self
		  doOrLog: [ self fylgja mrsFor: aDeclaration ]
		  forOperation: #Lookup
		  ifFailReturn: [ nil ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> origin [

	^ self fylgja derivativeModels detect: [ :derivative | 
		  derivative isDerivedFrom: origin ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> origin: aMOModelDerivative [

	origin := aMOModelDerivative
]

{ #category : #accessing }
FylgjaMigrationUIController >> privateCreateCheckpoint [
"
	fylgja push: (fylgja top derivative
			 installAllDerivativeModels;
			 yourself)"
]

{ #category : #accessing }
FylgjaMigrationUIController >> privateRollback [
	"
	self assert: fylgja size > 1 description: 'No earlier version found'.
	
	fylgja pop "
]

{ #category : #accessing }
FylgjaMigrationUIController >> produce: aProvenance applying: aRule into: aDestination informing: aWidget [

	| result |
	^ self
		  transactionalDoOrLog: [ 
			  self
				  assert: aProvenance isNotNil
				  description: ' Cannot resolve provenance entity .'.
			  self
				  assert: aDestination isNotNil
				  description: ' Cannot resolve destination .'.
				self
				  assert: aRule isNotNil
				  description: ' Not rule has been chosen.'.
				
			  result := self fylgja produce: aProvenance  applying: aRule into: aDestination.
			  self logSuccess: result operation: #Produce.
			  aWidget ruleHasBeenAppliedSuccessfully.
			  result ]
		  forOperation: #Produce
		  ifFailReturn: [ nil ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController >> produceCode: aMODeclarationUnit [

	^ (self fylgja selectDerivativeModelFor: aMODeclarationUnit) 
		  produceCode: aMODeclarationUnit
]

{ #category : #accessing }
FylgjaMigrationUIController >> projectName [

	^ projectName ifNil: [ 
		  projectName := 'Migration from: {1} to: {2} and {3} ' format: { 
				                 origin name.
				                 (',' join:
					                  (destinations allButLast collect: [ :a | 
						                   a name ])).
				                 destinations last name } ]
]

{ #category : #accessing }
FylgjaMigrationUIController >> pushFylgja [
	
	fylgja push: (fylgja top derivative
			 installAllDerivativeModels;
			 yourself).

	^ fylgja top
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
FylgjaMigrationUIController >> rollbackFor: aWidget [

	self
		doOrLog: [ 
			self flag: #Comment.
				" Should be using private rollback,"
				self assert: fylgja size > 1 description: 'No earlier version found'.
				
				fylgja pop .
			self
				logSuccess:
				'Successifull rollback. Version: ' , fylgja size asString
				operation: #Rollback.
			aWidget ruleHasBeenAppliedSuccessfully ]
		forOperation: #Rollback
		ifFailReturn: [ nil ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController >> saveRules [

	| fileName stream |
	self halt: 'Not yet fully supported. Ensure no model object is in any rule'.
	fileName := 'fylgja.mrs.version-' , self versionNumber asString
	            , '.ston'.
	stream := fileName asFileReference
		          ensureDelete;
		          writeStream.
	STON put: self fylgja migrationRuleSpace onStream: stream.
	stream flush.
	stream close
]

{ #category : #accessing }
FylgjaMigrationUIController >> stubsFor: aDeclaration [

	^ FylgjaReachableStubs new stubsFor: aDeclaration
]

{ #category : #accessing }
FylgjaMigrationUIController >> transactionalDoOrLog: aFullBlockClosure forOperation: aOperationName ifFailReturn: aBlock [

	^ [ 
	  self privateCreateCheckpoint.
	  aFullBlockClosure value ]
		  on: Error
		  do: [ :e | 
			  [ 
			  self logError: e operation: aOperationName.
			  self isDebugging
				  ifTrue: [ e pass ]
				  ifFalse: [ aBlock value ] ] ensure: [ self privateRollback ] ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController >> undoUpdateDestinationSourceProjectsInformTo: aWidget [

	| result |
	^ self
		  doOrLog: [ 
			  self assert:
				  (self destinations allSatisfy: #sourceCodeIsAvailable).

			  result := self destinations collect: [ :a | 
				            a undoUpdateDestinationSourceProjects ].

			  self logSuccess: result operation: #UndoUpdateSourceCode.
			  aWidget ruleHasBeenAppliedSuccessfully.
			  result ]
		  forOperation: #UndoUpdateSourceCode
		  ifFailReturn: [ nil ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController >> updateDestinationSourceProjectsInformTo: aWidget [

	| result |
	^ self
		  doOrLog: [ 
			  self assert:
				  (self destinations allSatisfy: #sourceCodeIsAvailable).

			  result := self destinations collect: [ :a | 
				            a updateDestinationSourceProjects ].

			  self logSuccess: result operation: #UpdateSourceCode.
			  aWidget ruleHasBeenAppliedSuccessfully.
			  result ]
		  forOperation: #UpdateSourceCode
		  ifFailReturn: [ nil ]
]

{ #category : #'as yet unclassified' }
FylgjaMigrationUIController >> usersOrSenders: aMOMethod [

	| derivative versions |
	derivative := self fylgja selectDerivativeModelFor: aMOMethod.
	versions := derivative allVersionsOf: aMOMethod.

	aMOMethod isInvocable ifTrue: [ 
		^ derivative allInvocations
			  select: [ :a | versions includes: a referee ]
			  thenCollect: [ :a | a callingInvocable ] ].
	aMOMethod isType ifTrue: [ 
		| candidates referrals |
		candidates := derivative allReferences
			              select: [ :r | versions includes: r referee ]
			              thenCollect: [ :r | 
				              | i |
				              i := r usingDeclaration ].
		referrals := aMOMethod symbolicName.
		^ ((derivative allLiterals
			    select: [ :l | 
				    l literal isString and: [ 
					    l literal includesSubstring: referrals caseSensitive: false ] ]
			    thenCollect: [ :r | 
				    | i |
				    i := r usingDeclaration ]) , (derivative objects
			    select: [ :o | 
				    o holder ~= self and: [ 
					    o state values anySatisfy: [ :v | v = referrals ] ] ]
			    thenCollect: [ :o | o holder ]) , candidates) removeDuplicates ].
	self halt.
	^ {  }
]

{ #category : #accessing }
FylgjaMigrationUIController >> versionNumber [

	^ fylgja size
]
