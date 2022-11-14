Class {
	#name : #FylgjaAnnotate,
	#superclass : #FylgjaModification,
	#instVars : [
		'packageName',
		'annotationName',
		'namedArguments',
		'arguments'
	],
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #'instance creation' }
FylgjaAnnotate class >> possibleWritingMessages [

	^ { #writeAnnotation: }
]

{ #category : #adding }
FylgjaAnnotate >> addArgument: anArgument [

	(arguments ifNil: [ arguments := OrderedCollection new ]) add:
		anArgument
]

{ #category : #adding }
FylgjaAnnotate >> addNamedArgument: anAssociation [

	(namedArguments ifNil: [ namedArguments := OrderedCollection new ]) 
		add: anAssociation
]

{ #category : #accessing }
FylgjaAnnotate >> annotationName: aString [ 
	annotationName := aString
]

{ #category : #'as yet unclassified' }
FylgjaAnnotate >> calculateArguments: aWriter [

	^ ((namedArguments ifNil: [ {  } ]) collect: [ :keyValue | 
		   aWriter writeUnregisteredExpression: [ :exp | 
			   exp
				   singleArgumentNamed: keyValue key
				   expression: [ :e | self literal: keyValue value with: exp ] ] ])
	  , ((arguments ifNil: [ {  } ]) collect: [ :d | 
			   self literal: d with: aWriter ])
]

{ #category : #'as yet unclassified' }
FylgjaAnnotate >> findCandidate: aWriter [

	^( (aWriter model allEntitiesSelect: [ :a | 
		   a isClassType and: [ 
			   a name = annotationName and: [ 
				   a packageReference name = packageName ] ] ]) ifEmpty: [ 
		  aWriter model catalogEntitiesSelect: [ :a | 
			  a isClassType and: [ 
				  a name = annotationName and: [ 
					  a packageReference name = packageName ] ] ] ]) first 
]

{ #category : #testing }
FylgjaAnnotate >> hasArguments [

	^ namedArguments isEmptyOrNil not or: [ arguments isEmptyOrNil not ]
]

{ #category : #'as yet unclassified' }
FylgjaAnnotate >> literal: aValue with: aMOExpressionWriter [

	^ aMOExpressionWriter literalForValue: aValue
]

{ #category : #accessing }
FylgjaAnnotate >> packageName: aString [ 
	packageName := aString
]

{ #category : #'instance creation' }
FylgjaAnnotate >> privateApplyOn: aWriter [

	| candidate |
	candidate := self findCandidate: aWriter.

	aWriter writeAnnotation: [ :annotation | 
		annotation annotationTypeReference:
			((annotation typeReferenceNamed: candidate name)
				 referee: candidate;
				 yourself).

		self hasArguments ifTrue: [ 
			annotation arguments: (self calculateArguments: annotation) ] ]
]
