Class {
	#name : #FylgjaFormToSpring,
	#superclass : #FylgjaGeneration,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #adding }
FylgjaFormToSpring >> addDaoDelegate: class for: aMOFormOrReport [

	^ FylgjaAddAnnotatedAttribute new
		  addAnnotationProduction: self annotatingAsAutoWired;
		  visibility: #protected;
		  name: (self daoNameFor: aMOFormOrReport) uncapitalized;
		  typeReference:
			  (class typeReferenceNamed: (self daoNameFor: aMOFormOrReport));
		  applyOn: class
]

{ #category : #adding }
FylgjaFormToSpring >> addServiceDelegate: class for: aMOFormOrReport [

	^ FylgjaAddAnnotatedAttribute new
		  addAnnotationProduction: self annotatingAsAutoWired;
		  visibility: #protected;
		  name: (self serviceNameFor: aMOFormOrReport) uncapitalized;
		  typeReference:
			  (class typeReferenceNamed: (self serviceNameFor: aMOFormOrReport));
		  applyOn: class
]

{ #category : #adding }
FylgjaFormToSpring >> addSessionFactoryAttribute: class for: aMOFormOrReport [

	| typeReference |
	typeReference := self
		                 calculateTypeReference: 'SessionFactory'
		                 packageName: 'org.hibernate'
		                 using: class.


	^ FylgjaAddAnnotatedAttribute new
		  addAnnotationProduction: self annotatingAsAutoWired;
		  visibility: #protected;
		  name: 'sessionFactory';
		  typeReference: typeReference;
		  applyOn: class
]

{ #category : #adding }
FylgjaFormToSpring >> addSetterAndGetter: aMOAttribute into: aWriter [

	FylgjaAddSetter new
		attribute: aMOAttribute;
		applyOn: aWriter.
		
	FylgjaAddGetter new
		attribute: aMOAttribute;
		applyOn: aWriter.
	
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> allDataBoundableAttributes: object model: model [

	| tableName |
	tableName := object state at: #RecordSource.
	self assert:
		(tableName includesSubstring: #select caseSensitive: false) not.
	^ (model entities select: [ :a | 
		   ((a isKindOf: MOAlceTable) or: [ a isKindOf: MOAlceQuery ]) and: [ 
			   a compareName: tableName ] ]) flatCollect: #attributes
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> annotate: class asTableNamed: tableName [

	^ FylgjaAnnotate new
		  packageName: 'javax.persistence';
		  annotationName: 'Table';
		  addNamedArgument: #name -> tableName;
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> annotateAsCrossOrigin: class withOriginAt: aString [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.web.bind.annotation';
		  annotationName: 'CrossOrigin';
		  addNamedArgument: #origins -> aString;
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> annotateAsEntity: class [

	^ FylgjaAnnotate new
		  packageName: 'javax.persistence';
		  annotationName: 'Entity';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> annotateAsRepository: class [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.stereotype';
		  annotationName: 'Repository';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> annotateAsRequestMapping: class mappingTo: aString [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.web.bind.annotation';
		  annotationName: 'RequestMapping';
		  addNamedArgument: #value -> aString;
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> annotateAsRestController: class [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.web.bind.annotation';
		  annotationName: 'RestController';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> annotateAsService: class [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.stereotype';
		  annotationName: 'Service';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> annotateAsTransactional: class [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.transaction.annotation';
		  annotationName: 'Transactional';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> annotatingAsAutoWired [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.beans.factory.annotation';
		  annotationName: 'Autowired'
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> annotatingAsGetMapping: aString [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.web.bind.annotation';
		  addNamedArgument: #value -> aString;
		  annotationName: 'RequestMapping'
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> annotatingProductionColumn: columnName [

	^ FylgjaAnnotate new
		  packageName: 'javax.persistence';
		  annotationName: 'Column';
		  addNamedArgument: #name -> columnName
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> collectAllDatabaseBindings: aMOObject marringWith: dbAttrs [

	^ (aMOObject state values
		   select: [ :val | 
			   (val isKindOf: MOObject) and: [ 
				   (val state includesKey: #ControlSource) and: [ 
					   (val state at: #ControlSource) isNotEmpty and: [ 
						   (val state at: #ControlSource) first ~= $= ] ] ] ]
		   thenCollect: [ :val | 
			   val -> (dbAttrs detect: [ :db | 
				    db compareName: (val state at: #ControlSource) ]) ])
		  asDictionary
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> controllerNameFor: aFormOrReport [

	^ (self saniteName: aFormOrReport) , '_Controller'
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> daoNameFor: aFormOrReport [

	^ (self saniteName: aFormOrReport) , '_DAO'
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> databaseSourceName: object [

	^ object state at: #RecordSource
]

{ #category : #testing }
FylgjaFormToSpring >> hasId: aMOAlceForm using: aFylgjaDerivativeModel [

	| model object tableName table |
	self assert: aMOAlceForm methods isEmpty.

	model := aFylgjaDerivativeModel selectDerivativeModelFor: aMOAlceForm.
	object := self defaultInstanceFor: aMOAlceForm withIn: model.

	tableName := self databaseSourceName: object.

	table := (model allEntitiesSelect: [ :a | 
		         a isDatasource and: [ 
			         a name = tableName or: [ 
				         a sanitizedName = (a sanitize: tableName) ] ] ]) first.


	^ table hasIdColumns
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> modelNameFor: aFormOrReport [

	^ (self saniteName: aFormOrReport) , '_Model'
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> saniteName: aFormOrReport [

	^ (aFormOrReport name copyReplaceAll: 'Form_' with: '')
		  copyReplaceAll: 'Report_'
		  with: ''
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> serviceNameFor: aFormOrReport [

	^ (self saniteName: aFormOrReport) , '_Service'
]

{ #category : #'instance creation' }
FylgjaFormToSpring >> typeReferenceListOf: aMOTypeReference using: aMOMethodWriter [

	| ref |
	ref := self
		       calculateTypeReference: #List
		       packageName: 'java.util'
		       using: aMOMethodWriter.

	ref argumentTypeReferences: { aMOTypeReference }.

	^ ref
]
