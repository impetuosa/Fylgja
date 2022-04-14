Class {
	#name : #FylgjaToSpring,
	#superclass : #FylgjaGeneration,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #adding }
FylgjaToSpring >> addAttribute: attr boundAs: instance croppingRelationsWith: aBlock destinationWriter: class lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| typeReference |
	typeReference := FylgjaMigrate new
		                 cropping: aBlock;
		                 fylgja: aFylgjaDerivativeModel;
		                 lookUp: aFylgjaLookUpContext;
		                 provenanceEntity: attr typeReference;
		                 applyOn: class.



	^ FylgjaAddAnnotatedAttribute new
		  addAnnotationProduction:
			  (self annotatingProductionColumn:
					   (instance state at: #ControlSource));
		  visibility: #protected;
		  name: attr name;
		  typeReference: typeReference;
		  applyOn: class
]

{ #category : #adding }
FylgjaToSpring >> addDaoDelegate: class for: aMOFormOrReport [

	^ FylgjaAddAnnotatedAttribute new
		  addAnnotationProduction: self annotatingAsAutoWired;
		  visibility: #protected;
		  name: (self daoNameFor: aMOFormOrReport) uncapitalized;
		  typeReference:
			  (class typeReferenceNamed: (self daoNameFor: aMOFormOrReport));
		  applyOn: class
]

{ #category : #adding }
FylgjaToSpring >> addServiceDelegate: class for: aMOFormOrReport [

	^ FylgjaAddAnnotatedAttribute new
		  addAnnotationProduction: self annotatingAsAutoWired;
		  visibility: #protected;
		  name: (self serviceNameFor: aMOFormOrReport) uncapitalized;
		  typeReference:
			  (class typeReferenceNamed: (self serviceNameFor: aMOFormOrReport));
		  applyOn: class
]

{ #category : #adding }
FylgjaToSpring >> addSessionFactoryAttribute: class for: aMOFormOrReport [

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
FylgjaToSpring >> addSetterAndGetter: aMOAttribute into: aWriter [

	FylgjaAddSetter new
		attribute: aMOAttribute;
		applyOn: aWriter.
		
	FylgjaAddGetter new
		attribute: aMOAttribute;
		applyOn: aWriter.
	
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> allDataBoundableAttributes: object model: model [

	| tableName |
	tableName := object state at: #RecordSource.
	self assert:
		(tableName includesSubstring: #select caseSensitive: false) not.
	^ (model entities select: [ :a | 
		   ((a isKindOf: MOAlceTable) or: [ a isKindOf: MOAlceQuery ]) and: [ 
			   a compareName: tableName ] ]) flatCollect: #attributes
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> annotate: class asTableNamed: tableName [

	^ FylgjaAnnotate new
		  packageName: 'javax.persistence';
		  annotationName: 'Table';
		  addNamedParameter: #name -> tableName;
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> annotateAsCrossOrigin: class withOriginAt: aString [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.web.bind.annotation';
		  annotationName: 'CrossOrigin';
		  addNamedParameter: #origins -> aString;
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> annotateAsEntity: class [

	^ FylgjaAnnotate new
		  packageName: 'javax.persistence';
		  annotationName: 'Entity';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> annotateAsRepository: class [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.stereotype';
		  annotationName: 'Repository';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> annotateAsRequestMapping: class mappingTo: aString [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.web.bind.annotation';
		  annotationName: 'RequestMapping';
		  addNamedParameter: #value -> aString;
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> annotateAsRestController: class [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.web.bind.annotation';
		  annotationName: 'RestController';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> annotateAsService: class [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.stereotype';
		  annotationName: 'Service';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> annotateAsTransactional: class [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.transaction.annotation';
		  annotationName: 'Transactional';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> annotatingAsAutoWired [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.beans.factory.annotation';
		  annotationName: 'Autowired'
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> annotatingAsGetMapping: aString [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.web.bind.annotation';
		  addNamedParameter: #value -> aString;
		  annotationName: 'RequestMapping'
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> annotatingProductionColumn: columnName [

	^ FylgjaAnnotate new
		  packageName: 'javax.persistence';
		  annotationName: 'Column';
		  addNamedParameter: #name -> columnName
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> calculateTypeReference: aString using: aMOClassWriter [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> collectAllDatabaseBindings: aMOObject marringWith: dbAttrs [

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
FylgjaToSpring >> controllerNameFor: aFormOrReport [

	^ (self saniteName: aFormOrReport) , '_Controller'
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> daoNameFor: aFormOrReport [

	^ (self saniteName: aFormOrReport) , '_DAO'
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> databaseSourceName: object [

	^ object state at: #RecordSource
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> defaultInstanceFor: aProvenanceEntity withIn: model [

	| object |
	object := model objectsSelect: [ :a | 
		          a type class = aProvenanceEntity class and: [ 
			          a type name = aProvenanceEntity name ] ].

	self assert: object size = 1.
	^ object first
]

{ #category : #testing }
FylgjaToSpring >> hasId: aMOAlceForm using: aFylgjaDerivativeModel [

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
FylgjaToSpring >> modelNameFor: aFormOrReport [

	^ (self saniteName: aFormOrReport) , '_Model'
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> saniteName: aFormOrReport [

	^ (aFormOrReport name copyReplaceAll: 'Form_' with: '')
		  copyReplaceAll: 'Report_'
		  with: ''
]

{ #category : #'as yet unclassified' }
FylgjaToSpring >> serviceNameFor: aFormOrReport [

	^ (self saniteName: aFormOrReport) , '_Service'
]

{ #category : #'instance creation' }
FylgjaToSpring >> typeReferenceListOf: aMOTypeReference using: aMOMethodWriter [

	| ref |
	ref := self
		       calculateTypeReference: #List
		       packageName: 'java.util'
		       using: aMOMethodWriter.

	ref argumentTypeReferences: { aMOTypeReference }.

	^ ref
]
