Class {
	#name : #FylgjaAngularModifications,
	#superclass : #FylgjaModification,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #adding }
FylgjaAngularModifications >> addAngularComponentDecorator: class [
	self halt: 'should rename properly '.
	^ FylgjaDecorate new
		  packageName: '@angular/core';
		  decoratorName: 'Component';
		  addArgument: { 
				  (#selector -> 'app-add-student').
				  (#templateUrl -> './add-student.component.html').
				  (#styleUrls -> { './add-student.component.css' }) } asDictionary;
		  applyOn: class
]

{ #category : #adding }
FylgjaAngularModifications >> addConstructorWithServiceParameter: class initializing: aMOAttribute [

	^ FylgjaAddAttributeInitializingConstructor new
		  attributes: { aMOAttribute };
		  applyOn: class
]

{ #category : #adding }
FylgjaAngularModifications >> addFormGroup: class name: aName bindings: bindings [

	^ FylgjaAngularInitializedFormGroup new
		  name: aName;
		  bindings: bindings;
		  applyOn: class
]

{ #category : #adding }
FylgjaAngularModifications >> addNgOnInitMethod: class [

	^ FylgjaAddEmptyMethod new
		  selector: #ngOnInit;
		  returnTypeReference: (class typeReferenceNamed: #void);
		  applyOn: class
]

{ #category : #adding }
FylgjaAngularModifications >> addOnInitSupertype: class [

	class addSuperTypeReference: (self
			 calculateTypeReference: 'OnInit'
			 packageName: '@angular/core'
			 using: class)
]

{ #category : #adding }
FylgjaAngularModifications >> addSubmitted: class [

	^ FylgjaAddAttribute new
		  visibility: #protected;
		  name: #submitted;
		  typeReference:
			  (self calculateTypeReference: #boolean using: class);
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaAngularModifications >> consoleLogLambda: writer [

	^ writer writeBlockClosure: [ :bc | 
		  | toLog |
		  toLog := bc writeParameter: [ :pm | pm name: #toLog ].
		  FylgjaAddMethodInvocation new
			  receiver: (bc variableReferenceNamed: #console);
			  selector: #log;
			  arguments: { (self variableReferenceTo: toLog using: bc) };
			  applyOn: bc ]
]

{ #category : #'as yet unclassified' }
FylgjaAngularModifications >> formControlReference: class [

	^ self
		  calculateTypeReference: #FormControl
		  packageName: '@angular/forms'
		  using: class
]

{ #category : #'as yet unclassified' }
FylgjaAngularModifications >> formGroupReference: class [

	^ self
		  calculateTypeReference: #FormGroup
		  packageName: '@angular/forms'
		  using: class
]
