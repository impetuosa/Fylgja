Class {
	#name : #FylgjaCandidateStub,
	#superclass : #FylgjaAbstractCandidateStub,
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #accessing }
FylgjaCandidateStub >> acceptVisitor: aMOJavaCodeGenerator [

	self provenance to acceptVisitor: aMOJavaCodeGenerator
]

{ #category : #accessing }
FylgjaCandidateStub >> printOn: aStream [

	aStream
		nextPutAll: 'Fylgja STUB: ';
		nextPutAll: (self parent name ifNil: [ self parent className ]);
		nextPutAll: 'Should Point To: ';
		print: candidate
]

{ #category : #'as yet unclassified' }
FylgjaCandidateStub >> refersToObjectsLike: aMOPrimitiveType [

	^ aMOPrimitiveType isCollection
		  ifTrue: [ aMOPrimitiveType allSatisfy: [ : a | self refersToObjectsLike: a ]  ]
		  ifFalse: [ aMOPrimitiveType isDeclaration ]
]
