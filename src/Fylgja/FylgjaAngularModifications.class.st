Class {
	#name : #FylgjaAngularModifications,
	#superclass : #FylgjaModification,
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #adding }
FylgjaAngularModifications >> addAngularComponentDecorator: class name: name templateName: templateName cssName: cssName [

	^ FylgjaDecorate new
		  packageName: '@angular/core';
		  decoratorName: 'Component';
		  addArgument: { 
				  (#selector -> name).
				  (#templateUrl
				   -> ('./{1}.component.html' format: { templateName })).
				  (#styleUrls -> { ('./{1}.component.css' format: { cssName }) }) }
				  asDictionary;
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

{ #category : #'as yet unclassified' }
FylgjaAngularModifications >> addNgOnInitMethod: class bindings: bindings service: aService [ 

	^ FylgjaAngularNgInit new
		  bindings: bindings;
		  service: aService;
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
