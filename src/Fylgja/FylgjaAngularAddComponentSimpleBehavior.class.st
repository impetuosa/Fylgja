Class {
	#name : #FylgjaAngularAddComponentSimpleBehavior,
	#superclass : #FylgjaAngularModifications,
	#instVars : [
		'name',
		'addToClassBlock',
		'modelClassReference',
		'serviceClassReference',
		'bindings',
		'cssName',
		'templateName',
		'methods',
		'fylgja',
		'lookUp',
		'croppingWith'
	],
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #'instance creation' }
FylgjaAngularAddComponentSimpleBehavior class >> possibleWritingMessages [

	^ { #writeDeclarationUnit: }
]

{ #category : #'instance creation' }
FylgjaAngularAddComponentSimpleBehavior >> addBindingsAttributes: class [

	| arrayRef |
	bindings do: [ :b | 
		class writeAttribute: [ :attr | 
			attr visibility: #public.
			attr name: b source daoAccessSelectorName.
			arrayRef := self
				            observableArrayTypeReference:
				            (b source resolveUsedModelClassUsing: class)
				            using: class.




			attr typeReference: arrayRef ] ]
]

{ #category : #adding }
FylgjaAngularAddComponentSimpleBehavior >> addFormDelegateGetters: aMOAttribute using: class [

	"
	  get StudentName(){  
    return this.studentsaveform.get('student_name');  
  }  "

	bindings keys do: [ :controlName | 
		class writeAttributeAccessor: [ :accessor | 
			accessor selector: controlName.
			accessor kind: #Get.
			accessor returnTypeReference: (accessor typeReferenceNamed: #any).
			accessor writeBlock: [ :block | 
				block writeReturn: [ :ret | 
					ret writeExpression: [ :exp | 
						exp
							invokeMethodNamed: #get
							receiver: [ :rexp | 
							self variableReferenceTo: aMOAttribute using: rexp ]
							arguments: [ :axp | { (axp stringLiteral: controlName) } ] ] ] ] ] ]
]

{ #category : #adding }
FylgjaAngularAddComponentSimpleBehavior >> addMethod: aMOClassProcedure [

	^ self methods add: aMOClassProcedure
]

{ #category : #adding }
FylgjaAngularAddComponentSimpleBehavior >> addSave: m delegateToService: service into: class [

	^ class writeMethod: [ :method | 
		  method selector: #save.
		  method writeBlock: [ :block | " this.studentservice.createStudent(this.student)  
      .subscribe(data => console.log(data), error => console.log(error));  
    this.student = new Student();  "
			  FylgjaAddChainedMethodInvocation new
				  receiver: (self variableReferenceTo: service using: class);
				  selector: #create;
				  arguments: { (self variableReferenceTo: m using: class) };
				  chained: (FylgjaAddMethodInvocation new
						   selector: #subscribe;
						   arguments: [ :exp | 
							   { 
								   (self consoleLogLambda: exp).
								   (self consoleLogLambda: exp) } ]);
				  applyOn: block ] ]
]

{ #category : #adding }
FylgjaAngularAddComponentSimpleBehavior >> addSaveModel: class invoking: aMethod [

	self assert: bindings isEmpty
]

{ #category : #adding }
FylgjaAngularAddComponentSimpleBehavior >> addServiceAttribute: class [

	^ FylgjaAddAttribute new
		  visibility: #protected;
		  name: serviceClassReference name asLowercase;
		  typeReference: serviceClassReference;
		  applyOn: class
]

{ #category : #'instance creation' }
FylgjaAngularAddComponentSimpleBehavior >> calculateReferenceToAnObservable: aString referenceCandidate: aCandidate using: class [

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

{ #category : #accessing }
FylgjaAngularAddComponentSimpleBehavior >> croppingWith: aBlock [

	croppingWith := aBlock
]

{ #category : #'as yet unclassified' }
FylgjaAngularAddComponentSimpleBehavior >> cssName: aString [

	cssName := aString
]

{ #category : #'as yet unclassified' }
FylgjaAngularAddComponentSimpleBehavior >> fylgja: aFylgjaDerivativeModel [

	fylgja := aFylgjaDerivativeModel
]

{ #category : #'as yet unclassified' }
FylgjaAngularAddComponentSimpleBehavior >> informUsageOf: aCSNUIInputText [

	aCSNUIInputText isBoundToData ifTrue: [ 
		bindings
			at: aCSNUIInputText realName
			put: aCSNUIInputText dataBinding ]
]

{ #category : #accessing }
FylgjaAngularAddComponentSimpleBehavior >> lookUp: aFylgjaLookUpContext [

	lookUp := aFylgjaLookUpContext
]

{ #category : #accessing }
FylgjaAngularAddComponentSimpleBehavior >> methods [

	^ methods ifNil: [ methods := OrderedCollection new ]
]

{ #category : #accessing }
FylgjaAngularAddComponentSimpleBehavior >> modelClassReference: aMOTypeReference [

	modelClassReference := aMOTypeReference
]

{ #category : #accessing }
FylgjaAngularAddComponentSimpleBehavior >> name: aString [

	name := aString
]

{ #category : #'instance creation' }
FylgjaAngularAddComponentSimpleBehavior >> observableArrayTypeReference: aClass using: class [

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

{ #category : #'instance creation' }
FylgjaAngularAddComponentSimpleBehavior >> privateApplyOn: component [

	| service form cls |
	bindings := Dictionary new.
	addToClassBlock ifNotNil: [ addToClassBlock value: self ].

	^ component writeDeclarationUnit: [ :unit | 
		  cls := unit writeTypescriptClass: [ :class | 
			         class name: name.
			         class addModifier: #export.
			         class visibility: #public.
			         self addOnInitSupertype: class.
			         self
				         addAngularComponentDecorator: class
				         name: name
				         templateName: templateName
				         cssName: cssName.

			         self addSubmitted: class.
			         service := self addServiceAttribute: class.
			         self addBindingsAttributes: class.


			         self
				         addConstructorWithServiceParameter: class
				         initializing: service.

			         self
				         addNgOnInitMethod: class
				         bindings: bindings
				         service: service.

			         form := self
				                 addFormGroup: class
				                 name: #formValueHolder
				                 bindings: bindings.

			         self addFormDelegateGetters: form using: class.

			         self methods do: [ :m | 
				         FylgjaMigrate new
					         cropping: croppingWith;
					         fylgja: fylgja;
					         lookUp: lookUp;
					         provenanceEntity: m;
					         applyOn: class ] ].

		  (self importableDependencies: cls) do: [ :type | 
			  unit writeImport: [ :import | 
				  import importingTypeOrTypeReference: type ] ] ]
]

{ #category : #accessing }
FylgjaAngularAddComponentSimpleBehavior >> serviceClassReference: aMOTypeReference [

	serviceClassReference := aMOTypeReference
]

{ #category : #'as yet unclassified' }
FylgjaAngularAddComponentSimpleBehavior >> templateName: aString [

	templateName := aString
]

{ #category : #'as yet unclassified' }
FylgjaAngularAddComponentSimpleBehavior >> withinTheClass: aFullBlockClosure [ 
	addToClassBlock := aFullBlockClosure
]
