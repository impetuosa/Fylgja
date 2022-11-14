Class {
	#name : #FylgjaUIAddAnnotation,
	#superclass : #FylgjaUIDeclarationCommand,
	#category : #'Fylgja-UI-Command-Model'
}

{ #category : #accessing }
FylgjaUIAddAnnotation class >> defaultName [ 
	 ^ 'Add Annotation'
]

{ #category : #testing }
FylgjaUIAddAnnotation >> addParametersTo: op [

	| input |
	[ 
	input := UIManager default
		         request:
		         'Add parameters for the annotation such as var = value or value. Cancel for finish'
		         initialAnswer: ''.
	input isEmptyOrNil ] whileFalse: [ 
		(input includesSubstring: #=)
			ifTrue: [ 
				input := #= split: input.
				op addNamedArgument: input first -> input second ]
			ifFalse: [ op addArgument: input ] ]
]

{ #category : #testing }
FylgjaUIAddAnnotation >> canBeExecuted [

	^ self context selectedItems size = 1 and: [ 
		  self context selectedItems allSatisfy: [ :e | 
			  e respondsTo: #annotationInstances ] ]
]

{ #category : #testing }
FylgjaUIAddAnnotation >> execute [

	| annotationName annotationPackageName op |
	annotationName := UIManager default
		                  request: 'Annotation Class name'
		                  initialAnswer: 'MyClass'.
	annotationName ifNil: [ ^ self ].
	annotationPackageName := UIManager default
		                         request: 'Annotation package name'
		                         initialAnswer: 'java.lang'.
	annotationPackageName ifNil: [ ^ self ].
	
	op := FylgjaAnnotate new
		      packageName: annotationPackageName;
		      annotationName: annotationName;
		      yourself.
		
	self addParametersTo: op.
	
	self apply: [ :mod :modWriter | op applyOn: modWriter ]
]
