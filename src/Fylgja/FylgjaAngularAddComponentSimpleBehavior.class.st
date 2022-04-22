Class {
	#name : #FylgjaAngularAddComponentSimpleBehavior,
	#superclass : #FylgjaAngularModifications,
	#instVars : [
		'name',
		'addToClassBlock',
		'modelClassReference',
		'serviceClassReference',
		'bindings',
		'model'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #adding }
FylgjaAngularAddComponentSimpleBehavior >> addFormDelegateGetters: aMOAttribute [ 
	self assert: bindings isEmpty. 
	
	"
	  get StudentName(){  
    return this.studentsaveform.get('student_name');  
  }  "
]

{ #category : #adding }
FylgjaAngularAddComponentSimpleBehavior >> addModelAttribute: class [

	^ FylgjaAddAttribute new
		  visibility: #protected;
		  name: modelClassReference name asLowercase;
		  typeReference: modelClassReference;
		  applyOn: class
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
FylgjaAngularAddComponentSimpleBehavior >> applyOn: component [

	| service form save cls |
	bindings := Dictionary new.
	addToClassBlock ifNotNil: [ addToClassBlock value: self ].

	^ component writeDeclarationUnit: [ :unit | 
		  cls := unit writeTypescriptClass: [ :class | 
			         class name: name.
						class addModifier: #export. 
						class visibility: #public. 
			         self addOnInitSupertype: class.
			         self addAngularComponentDecorator: class.


			         model := self addModelAttribute: class.
			         self addSubmitted: class.
			         service := self addServiceAttribute: class.
			         self
				         addConstructorWithServiceParameter: class
				         initializing: service.


			         self addNgOnInitMethod: class.

			         form := self
				                 addFormGroup: class
				                 name: #formValueHolder
				                 bindings: bindings.
			         self addFormDelegateGetters: form.
			         save := self
				                 addSave: model
				                 delegateToService: service
				                 into: class.


			         self addSaveModel: class invoking: save ].

		  (self importableDependencies: cls) do: [ :type | 
			  unit writeImport: [ :import | 
				  type isReference
					  ifTrue: [ import importingTypeReference: type ]
					  ifFalse: [ import importType: type ] ] ] ]
]

{ #category : #'as yet unclassified' }
FylgjaAngularAddComponentSimpleBehavior >> informUsageOf: aCSNUIInputText [

	aCSNUIInputText isBoundToData ifTrue: [ 
		bindings at: aCSNUIInputText name put: aCSNUIInputText dataBinding ]
]

{ #category : #accessing }
FylgjaAngularAddComponentSimpleBehavior >> modelClassReference: aMOTypeReference [

	modelClassReference := aMOTypeReference
]

{ #category : #accessing }
FylgjaAngularAddComponentSimpleBehavior >> name: aString [

	name := aString
]

{ #category : #accessing }
FylgjaAngularAddComponentSimpleBehavior >> serviceClassReference: aMOTypeReference [

	serviceClassReference := aMOTypeReference
]

{ #category : #'as yet unclassified' }
FylgjaAngularAddComponentSimpleBehavior >> withinTheClass: aFullBlockClosure [ 
	addToClassBlock := aFullBlockClosure
]
