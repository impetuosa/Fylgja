Class {
	#name : #FylgjaAnnotate,
	#superclass : #FylgjaModification,
	#instVars : [
		'packageName',
		'annotationName',
		'namedParameters'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #adding }
FylgjaAnnotate >> addNamedParameter: anAssociation [

	(namedParameters ifNil: [ namedParameters := OrderedCollection new ]) 
		add: anAssociation
]

{ #category : #accessing }
FylgjaAnnotate >> annotationName: aString [ 
	annotationName := aString
]

{ #category : #'instance creation' }
FylgjaAnnotate >> applyOn: aWriter [

	| candidate |
	candidate := self findCandidate: aWriter.

	aWriter writeAnnotation: [ :annotation | 
		annotation annotationTypeReference:
			((annotation typeReferenceNamed: candidate name)
				 candidate: candidate;
				 yourself).

		self hasArguments ifTrue: [ 
			annotation arguments: (self calculateArguments: annotation) ] ]
]

{ #category : #querying }
FylgjaAnnotate >> calculateArguments [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FylgjaAnnotate >> calculateArguments: aWriter [

	^ namedParameters collect: [ :keyValue | 
		  aWriter writeUnregisteredExpression: [ :exp | 
			  exp
				  argumentNamed: keyValue key
				  expression: [ :e | { (self literal: keyValue value with: exp) } ] ] ]
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

	^ namedParameters isEmptyOrNil not
]

{ #category : #'as yet unclassified' }
FylgjaAnnotate >> literal: aValue with: aMOExpressionWriter [

	aValue isString ifTrue: [ 
		^ aMOExpressionWriter stringLiteral: aValue ].
	aValue isNumber ifTrue: [ 
		^ aMOExpressionWriter numericLiteral: aValue ].
	self error: 'Literal not yet implemented'
]

{ #category : #accessing }
FylgjaAnnotate >> packageName: aString [ 
	packageName := aString
]
