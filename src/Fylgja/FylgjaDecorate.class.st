Class {
	#name : #FylgjaDecorate,
	#superclass : #FylgjaAnnotate,
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #'instance creation' }
FylgjaDecorate class >> possibleWritingMessages [

	^ { #writeDecorator: }
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

{ #category : #'instance creation' }
FylgjaDecorate >> privateApplyOn: aWriter [

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
