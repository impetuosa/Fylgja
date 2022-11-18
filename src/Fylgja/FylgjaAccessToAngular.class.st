Class {
	#name : #FylgjaAccessToAngular,
	#superclass : #FylgjaFromAccess,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'as yet unclassified' }
FylgjaAccessToAngular >> calculateReferenceToAnObservable: aString using: class [

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
FylgjaAccessToAngular >> decorateAsInjectableIn: aString into: class [

	^ FylgjaDecorate new
		  packageName: '@angular/core';
		  decoratorName: 'Injectable';
		  addArgument: { (#providedIn -> aString) } asDictionary;
		  applyOn: class
]
