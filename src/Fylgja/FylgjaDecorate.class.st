Class {
	#name : #FylgjaDecorate,
	#superclass : #FylgjaAnnotate,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaDecorate >> applyOn: aWriter [

	| candidate |
	candidate := self findCandidate: aWriter.

	^ aWriter writeDecorator: [ :annotation | 
		  annotation decoratorTypeReference:
			  ((annotation typeReferenceNamed: annotationName)
				   packageReference:
					   (annotation packageReferenceNamed: packageName);
				   candidate: candidate;
				   yourself).
		  self hasArguments ifTrue: [ 
			  annotation arguments: (self calculateArguments: annotation) ] ]
]

{ #category : #'as yet unclassified' }
FylgjaDecorate >> decoratorName: aString [

	self annotationName: aString
]

{ #category : #'instance creation' }
FylgjaDecorate >> findCandidate: aWriter [

	| candidates |
	candidates := (aWriter model allEntitiesSelect: [ :a | 
		               a isClassType and: [ 
			               a name = annotationName and: [ 
				               a packageReference name = packageName ] ] ]) 
		              ifEmpty: [ 
			              aWriter model catalogEntitiesSelect: [ :a | 
				              a isClassType and: [ 
					              a name = annotationName and: [ 
						              a packageReference name = packageName ] ] ] ].
	^ candidates ifEmpty: [ nil ] ifNotEmpty: [ candidates first ]
]
