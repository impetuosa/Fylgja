Class {
	#name : #FylgjaUIAddClass,
	#superclass : #FylgjaUIDeclarationCommand,
	#category : #'Fylgja-UI-Command-Model'
}

{ #category : #'accessing - defaults' }
FylgjaUIAddClass class >> defaultName [ 
	 ^ 'Add Class'
]

{ #category : #testing }
FylgjaUIAddClass >> canBeExecuted [

	^ self context selectedItems isEmptyOrNil not and: [ 
		  self context selectedItems allSatisfy: [ :a | 
			  { 
				  MOPackage.
				  MODeclarationUnit.
				  MOJavaClass } anySatisfy: [ :t | a isKindOf: t ] ] ]
]

{ #category : #testing }
FylgjaUIAddClass >> execute [

	| className superClassName |
	className := UIManager default
		             request: 'Class name'
		             initialAnswer: 'MyClass'.
	superClassName := UIManager default
		                  request: 'Superclass Full Name'
		                  initialAnswer: 'java.lang.Object'.
	className isEmptyOrNil ifTrue: [ ^ self ].
	self apply: [ :elem :destinationWriter | 
		FylgjaAddClass new
			className: className;
			superClassName: superClassName;
			applyOn: destinationWriter ]
]
