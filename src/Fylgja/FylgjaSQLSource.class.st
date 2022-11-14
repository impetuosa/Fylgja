Class {
	#name : #FylgjaSQLSource,
	#superclass : #FylgjaFormToSpring,
	#instVars : [
		'sql',
		'bindingObject',
		'sessionFactory',
		'accessedAttributes',
		'fromTables',
		'fylgja',
		'orderBy',
		'service'
	],
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'Famix-Extensions-metrics-support' }
FylgjaSQLSource >> accessedAttributes [

	^ accessedAttributes ifNil: [ 
		  accessedAttributes := Set new ]
]

{ #category : #adding }
FylgjaSQLSource >> addEntityManagerAttribute: class [

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

{ #category : #'instance creation' }
FylgjaSQLSource >> applyOn: aMOClassWriter [

	self error:
		'This is a multiple propose object. Please use the specialized version of applyOn: accordign to your case '
]

{ #category : #'as yet unclassified' }
FylgjaSQLSource >> applyOnController: aMOJavaClassWriter [

	| model |
	model := self resolveUsedModelClassUsing: aMOJavaClassWriter.
	^ FylgjaAddAnnotatedDelegateMethod new
		  addAnnotationProduction:
			  (self annotatingAsGetMapping: self daoAccessSelectorName);
		  attributeReference:
			  (self variableReferenceTo: service using: aMOJavaClassWriter);
		  returnTypeReference: (self
				   typeReferenceListOf: (self
						    calculateTypeReference: model name
						    packageName: model packageName
						    using: aMOJavaClassWriter)
				   using: aMOJavaClassWriter);
		  selector: self daoAccessSelectorName;
		  parameters: {  };
		  applyOn: aMOJavaClassWriter
]

{ #category : #'instance creation' }
FylgjaSQLSource >> applyOnDao: aMOClassWriter [

	| entityManager createNativeQuery model |
	entityManager := aMOClassWriter attributes
		                 detect: [ :a | a name = #entityManager ]
		                 ifNone: [ 
		                 self addEntityManagerAttribute: aMOClassWriter ].
	model := self resolveUsedModelClassUsing: aMOClassWriter.

	aMOClassWriter methods
		detect: [ :m | m selector = self daoAccessSelectorName ]
		ifNone: [ 
			createNativeQuery := entityManager typeReference referee 
				                     ifNotNil: [ :c | 
					                     c methods
						                     detect: [ :a | 
						                     a selector = #createNativeQuery and: [ 
							                     a parameters size = 2 ] ]
						                     ifNone: nil ].

			^ FylgjaAddDelegateMethodWithArguments new
				  attributeReference:
					  (self variableReferenceTo: entityManager using: aMOClassWriter);
				  returnTypeReference: (self
						   typeReferenceListOf: (self
								    calculateTypeReference: model name
								    packageName: model packageName
								    using: aMOClassWriter)
						   using: aMOClassWriter);
				  selector: self daoAccessSelectorName;
				  delegatingMethod: createNativeQuery;
				  delegatingSelector: #createNativeQuery;
				  arguments: [ :writer | 
					  { 
						  (writer stringLiteral:
								   ('SELECT * FROM {1}' format: { fromTables anyOne })).
						  (writer accessAttribute: #class receiver: [ :r | 
								   (writer typeReferenceNamed: model name)
									   referee: model;
									   yourself ]) } ];
				  applyOn: aMOClassWriter ]
]

{ #category : #'as yet unclassified' }
FylgjaSQLSource >> applyOnFrontEndService: class delegateTo: httpClient url: url [

	| model |
	model := self resolveUsedModelClassUsing: class.

	^ class writeMethod: [ :method | 
		  method selector: self daoAccessSelectorName.
		  method returnTypeReference:
			  (self observableArrayTypeReference: model using: class).

		  method writeBlock: [ :block | 
			  block writeReturn: [ :return | 
				  return writeExpression: [ :exp | 
					  exp
						  invokeMethodNamed: #get
						  receiver: [ :e | 
						  self variableReferenceTo: httpClient using: e ]
						  arguments: [ :argExp | 
							  { (argExp
								   operate: [ :o | self variableReferenceTo: url using: o ]
								   operator: #+
								   with: [ :o | o stringLiteral: self daoAccessSelectorName ]) } ] ] ] ] ]
]

{ #category : #'instance creation' }
FylgjaSQLSource >> applyOnService: aMOClassWriter [

	| dao model attr |
	dao := self resolveUsedDAOUsing: aMOClassWriter.
	model := self resolveUsedModelClassUsing: aMOClassWriter.



	attr := aMOClassWriter attributes
		        detect: [ :a | a typeReference name = dao name ]
		        ifNone: [ 
			        self
				        addAutowiredAttribute: dao name uncapitalized
				        type: dao
				        into: aMOClassWriter ].


	^ FylgjaAddDelegateAndTransmitParametersMethod new
		  attributeReference:
			  (self variableReferenceTo: attr using: aMOClassWriter);
		  returnTypeReference: (self
				   calculateTypeReference: model name
				   packageName: model packageName
				   using: aMOClassWriter);
		  selector: self daoAccessSelectorName;
		  parameters: {  };
		  applyOn: aMOClassWriter
]

{ #category : #'as yet unclassified' }
FylgjaSQLSource >> bindingObject: aMOObject [

	bindingObject := aMOObject
]

{ #category : #'as yet unclassified' }
FylgjaSQLSource >> calculateReferenceToAnObservable: aString referenceCandidate: aCandidate using: class [

	| observable |

	observable := self
		              calculateParametrizableTypeReference: 'Observable'
		              packageName: 'rxjs'
		              using: class.
	observable argumentTypeReferences:
		{ ((self calculateTypeReference: aString using: class)
			 referee: aCandidate;
			 yourself) }.
	^ observable
]

{ #category : #initialization }
FylgjaSQLSource >> calculateReferenceToAnObservable: aString using: class [

	| observable |
	observable := self
		              calculateParametrizableTypeReference: 'Observable'
		              packageName: 'rxjs'
		              using: class.
	observable argumentTypeReferences:
		{ (self calculateTypeReference: aString using: class) }.
	^ observable
]

{ #category : #'as yet unclassified' }
FylgjaSQLSource >> daoAccessSelectorName [

	| orderByString fromString |

	fromString := '' join:
		              ((self fromTables sorted: #yourself ascending) 
			               collect: [ :e | MOObject sanitize: e ]).
	self orderBy ifEmpty: [ orderByString := '' ] ifNotEmpty: [ 
		orderByString := 'OrderedBy' , ('' join:
			                  ((self orderBy sorted: #yourself ascending) 
				                   collect: [ :e | MOObject sanitize: e ])) ].

	^ 'getAll{1}{2}' format: { 
			  fromString.
			  orderByString }
]

{ #category : #'instance creation' }
FylgjaSQLSource >> fromTables [

	^ fromTables ifNil: [ fromTables := Set new ]
]

{ #category : #accessing }
FylgjaSQLSource >> fylgja: aFylgjaDerivativeModel [

	fylgja := aFylgjaDerivativeModel
]

{ #category : #testing }
FylgjaSQLSource >> isHibernateRepository: aMOClass [

	^ aMOClass annotationInstances anySatisfy: [ :a | 
		  a typeReference name = #Repository ]
]

{ #category : #'as yet unclassified' }
FylgjaSQLSource >> observableArrayTypeReference: aClass using: class [

	| observable |
	observable := self
		              calculateParametrizableTypeReference: 'Observable'
		              packageName: 'rxjs'
		              using: class.

	observable argumentTypeReferences: { (class arrayTypeReferenceOf:
			 ((self calculateTypeReference: aClass name using: class)
				  referee: aClass;
				  yourself)) }.
	^ observable
]

{ #category : #generated }
FylgjaSQLSource >> orderBy [

	^ orderBy ifNil: [ orderBy := Set new ]
]

{ #category : #'instance creation' }
FylgjaSQLSource >> resolveUsedDAOUsing: aMOClassWriter [

	| daoName |
	self assert: fromTables size = 1.

	daoName := self daoNameForString: fromTables anyOne.

	^ aMOClassWriter model allEntitiesDetect: [ :a | 
		  (a isKindOf: MOClass) and: [ 
			  (self isHibernateRepository: a) and: [ a name = daoName ] ] ]
]

{ #category : #'instance creation' }
FylgjaSQLSource >> resolveUsedModelClassUsing: aMOClassWriter [

	| modelName |
	self assert: fromTables size = 1.
	modelName := self modelNameForString: fromTables anyOne.
	^ aMOClassWriter model allEntitiesDetect: [ :a | 
		  (a isKindOf: MOClass) and: [ a name = modelName ] ]
]

{ #category : #accessing }
FylgjaSQLSource >> service: aMOAttribute [

	service := aMOAttribute
]

{ #category : #accessing }
FylgjaSQLSource >> sessionFactory: aMOAttribute [

	sessionFactory := aMOAttribute
]

{ #category : #'as yet unclassified' }
FylgjaSQLSource >> singleEntityName [ 

	|  fromString |

	fromString := '' join:
		              ((self fromTables sorted: #yourself ascending) 
			               collect: [ :e | MOObject sanitize: e ]).
	
	^ fromString uncapitalized 
]

{ #category : #initialization }
FylgjaSQLSource >> sql: aString [

	sql := aString.
	(PostgreSQLParser parseSelectQuery: sql toPG) acceptVisitor: self.
	self assert: fromTables size = 1
]

{ #category : #visiting }
FylgjaSQLSource >> visitPSQLASTAttributeAccess: aPSQLASTAttributeAccess [

	self accessedAttributes add:
		(aPSQLASTAttributeAccess accessed acceptVisitor: self)
]

{ #category : #visiting }
FylgjaSQLSource >> visitPSQLASTFromClause: aPSQLASTFromClause [

	aPSQLASTFromClause children do: [ :c | c acceptVisitor: self ]
]

{ #category : #visiting }
FylgjaSQLSource >> visitPSQLASTFromClauseItemType1: aPSQLASTFromClauseItemType1 [

	self fromTables add:
		(aPSQLASTFromClauseItemType1 tableName acceptVisitor: self)
]

{ #category : #visiting }
FylgjaSQLSource >> visitPSQLASTIdentifier: aPSQLASTIdentifier [

	^ aPSQLASTIdentifier identifier copyReplaceAll: '"' with: ''
]

{ #category : #visiting }
FylgjaSQLSource >> visitPSQLASTOrderByClause: aPSQLASTOrderByClause [
	aPSQLASTOrderByClause children do: [ :c | c acceptVisitor: self ]
]

{ #category : #visiting }
FylgjaSQLSource >> visitPSQLASTOrderByClauseItem: aPSQLASTOrderByClauseItem [

	self orderBy add:
		(aPSQLASTOrderByClauseItem expression accessed acceptVisitor: self)
]

{ #category : #visiting }
FylgjaSQLSource >> visitPSQLASTSelectQuery: aPSQLASTSelectQuery [

	aPSQLASTSelectQuery children do: [ :c | c acceptVisitor: self ]
]
