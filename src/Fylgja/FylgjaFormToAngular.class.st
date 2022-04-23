Class {
	#name : #FylgjaFormToAngular,
	#superclass : #FylgjaFromAccess,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #adding }
FylgjaFormToAngular >> addBaseUrlVariable: class [

	^ FylgjaAddAttribute new
		  name: #baseUrl;
		  typeReference:
			  (self calculateTypeReference: 'string' using: class);
		  initializer: (class stringLiteral: 'http://localhost:8080/api/');
		  applyOn: class
]

{ #category : #adding }
FylgjaFormToAngular >> addConstructor: class initializing: aMOAttribute [

	^ FylgjaAddAttributeInitializingConstructor new
		  attributes: { aMOAttribute };
		  applyOn: class
]

{ #category : #adding }
FylgjaFormToAngular >> addHttpClientVariable: class [

	^ FylgjaAddAttribute new
		  name: #http;
		  typeReference: (self
				   calculateTypeReference: 'HttpClient'
				   packageName: '@angular/common/http'
				   using: class);
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> calculateReferenceToAnObservable: aString [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> calculateReferenceToAnObservable: aString using: class [

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
FylgjaFormToAngular >> decorateAsInjectableIn: aString into: class [

	^ FylgjaDecorate new
		  packageName: '@angular/core';
		  decoratorName: 'Injectable';
		  addArgument: { (#providedIn -> aString) } asDictionary;
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> resolveModelClassReferenceFor: aRelatedProvenanceEntity using: writer [

	^ self
		  calculateTypeReference:
		  (self modelNameFor: aRelatedProvenanceEntity to name)
		  using: writer
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> resolveServiceClassReferenceFor: aRelatedProvenanceEntity using: writer [

	^ self
		  calculateTypeReference:
		  (self serviceNameFor: aRelatedProvenanceEntity to name)
		  using: writer
]
