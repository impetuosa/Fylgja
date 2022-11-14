Class {
	#name : #FylgjaAccessToSpring,
	#superclass : #FylgjaFromAccess,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> addAttribute: attr annotatedAsColumnNamed: aColumnName croppingRelationsWith: aBlock destinationWriter: class lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| typeReference operation |
	typeReference := FylgjaMigrate new
		                 cropping: aBlock;
		                 fylgja: aFylgjaDerivativeModel;
		                 lookUp: aFylgjaLookUpContext;
		                 provenanceEntity: attr typeReference;
		                 applyOn: class.

	operation := FylgjaAddAnnotatedAttribute new
		             visibility: #public;
		             name: attr sanitizedName ;
		             typeReference: typeReference.
	operation addAnnotationProduction:
		(self annotatingProductionColumn: aColumnName).
	attr isPrimaryKey ifTrue: [ 
		operation addAnnotationProduction: self annotatingAsId ].
	^ operation applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> addAutowiredAttribute: aName type: aType into: class [

	| typeReference |
	typeReference := self
		                 calculateTypeReference: aType name
		                 packageName: aType packageName
		                 using: class.

	typeReference referee: aType.

	^ FylgjaAddAnnotatedAttribute new
		  addAnnotationProduction: self annotatingAsAutoWired;
		  visibility: #protected;
		  name: aName;
		  typeReference: typeReference;
		  applyOn: class
]

{ #category : #adding }
FylgjaAccessToSpring >> addDaoDelegate: class for: aMOFormOrReport [

	^ FylgjaAddAnnotatedAttribute new
		  addAnnotationProduction: self annotatingAsAutoWired;
		  visibility: #protected;
		  name: (self daoNameFor: aMOFormOrReport) uncapitalized;
		  typeReference:
			  (class typeReferenceNamed: (self daoNameFor: aMOFormOrReport));
		  applyOn: class
]

{ #category : #adding }
FylgjaAccessToSpring >> addDeleteModelMethod: class for: aFormOrReport using: aSessionFactoryAttribute [

	^ FylgjaAddHibernateMethodDeleteModel new
		sessionFactory: aSessionFactoryAttribute;
		modelTypeReference:
			(class typeReferenceNamed: (self modelNameFor: aFormOrReport));
		applyOn: class
]

{ #category : #adding }
FylgjaAccessToSpring >> addEntityManagerAttribute: class [

	| typeReference |
	typeReference := self
		                 calculateTypeReference: 'EntityManager'
		                 packageName: 'org.hibernate'
		                 using: class.


	^ FylgjaAddAnnotatedAttribute new
		  addAnnotationProduction: self annotatingAsAutoWired;
		  visibility: #protected;
		  name: 'entityManager';
		  typeReference: typeReference;
		  applyOn: class
]

{ #category : #adding }
FylgjaAccessToSpring >> addEntityManagerAttribute: class for: aMOFormOrReport [

	| typeReference |
	typeReference := self
		                 calculateTypeReference: 'EntityManager'
		                 packageName: 'org.hibernate'
		                 using: class.


	^ FylgjaAddAnnotatedAttribute new
		  addAnnotationProduction: self annotatingAsAutoWired;
		  visibility: #protected;
		  name: 'entityManager';
		  typeReference: typeReference;
		  applyOn: class
]

{ #category : #adding }
FylgjaAccessToSpring >> addGetAllMethod: class for: aFormOrReport using: aSessionFactoryAttribute [

	^ FylgjaAddHibernateMethodGetAllModel new
		  sessionFactory: aSessionFactoryAttribute;
		  modelTypeReference:
			  (class typeReferenceNamed: (self modelNameFor: aFormOrReport));
		  applyOn: class
]

{ #category : #adding }
FylgjaAccessToSpring >> addSaveModelMethod: class for: aFormOrReport using: aSessionFactoryAttribute [

	^ FylgjaAddHibernateMethodSaveModel new
		sessionFactory: aSessionFactoryAttribute;
		modelTypeReference:
			(class typeReferenceNamed: (self modelNameFor: aFormOrReport));
		applyOn: class
]

{ #category : #adding }
FylgjaAccessToSpring >> addServiceDelegate: class for: aMOFormOrReport [

	^ FylgjaAddAnnotatedAttribute new
		  addAnnotationProduction: self annotatingAsAutoWired;
		  visibility: #protected;
		  name: (self serviceNameFor: aMOFormOrReport) uncapitalized;
		  typeReference:
			  (class typeReferenceNamed: (self serviceNameFor: aMOFormOrReport));
		  applyOn: class
]

{ #category : #adding }
FylgjaAccessToSpring >> addSessionFactoryAttribute: class for: aMOFormOrReport [

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
FylgjaAccessToSpring >> addSetterAndGetter: aMOAttribute into: aWriter [

	FylgjaAddSetter new
		attribute: aMOAttribute;
		applyOn: aWriter.
		
	FylgjaAddGetter new
		attribute: aMOAttribute;
		applyOn: aWriter.
	
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> annotate: class asTableNamed: tableName [

	^ FylgjaAnnotate new
		  packageName: 'javax.persistence';
		  annotationName: 'Table';
		  addNamedArgument: #name -> tableName;
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> annotateAsCrossOrigin: class withOriginAt: aString [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.web.bind.annotation';
		  annotationName: 'CrossOrigin';
		  addNamedArgument: #origins -> aString;
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> annotateAsEntity: class [

	^ FylgjaAnnotate new
		  packageName: 'javax.persistence';
		  annotationName: 'Entity';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> annotateAsId: class [

	^ self annotatingAsId applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> annotateAsRepository: class [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.stereotype';
		  annotationName: 'Repository';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> annotateAsRequestMapping: class mappingTo: aString [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.web.bind.annotation';
		  annotationName: 'RequestMapping';
		  addNamedArgument: #value -> aString;
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> annotateAsRestController: class [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.web.bind.annotation';
		  annotationName: 'RestController';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> annotateAsService: class [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.stereotype';
		  annotationName: 'Service';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> annotateAsTransactional: class [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.transaction.annotation';
		  annotationName: 'Transactional';
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> annotatingAsAutoWired [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.beans.factory.annotation';
		  annotationName: 'Autowired';
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> annotatingAsGetMapping: aString [

	^ FylgjaAnnotate new
		  packageName: 'org.springframework.web.bind.annotation';
		  addNamedArgument: #value -> aString;
		  annotationName: 'RequestMapping';
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> annotatingAsId [

	^ FylgjaAnnotate new
		  packageName: 'javax.persistence';
		  annotationName: 'Id';
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> annotatingProductionColumn: columnName [

	^ FylgjaAnnotate new
		  packageName: 'javax.persistence';
		  annotationName: 'Column';
		  addNamedArgument: #name -> columnName
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> controllerNameFor: aFormOrReport [

	^ (self sanitizeName: aFormOrReport) , '_Controller'
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> daoNameFor: aFormOrReport [

	^ (self sanitizeName: aFormOrReport) , '_DAO'
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> daoNameForString: aString [

	^ (MOObject sanitize: aString) , '_DAO'
]

{ #category : #'instance creation' }
FylgjaAccessToSpring >> typeReferenceListOf: aMOTypeReference using: aMOMethodWriter [

	| ref |
	ref := self
		       calculateTypeReference: #List
		       packageName: 'java.util'
		       using: aMOMethodWriter.

	ref argumentTypeReferences: { aMOTypeReference }.

	^ ref
]

{ #category : #'as yet unclassified' }
FylgjaAccessToSpring >> updateModelMethod: class for: aFormOrReport using: aSessionFactoryAttribute [

	^ FylgjaAddHibernateMethodUpdateModel new
		  sessionFactory: aSessionFactoryAttribute;
		  modelTypeReference:
			  (class typeReferenceNamed: (self modelNameFor: aFormOrReport));
		  applyOn: class
]
