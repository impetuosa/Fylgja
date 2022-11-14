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
		nextPutAll: 'Stub: ';
		nextPutAll: self parent printString;
		nextPutAll: ' Should Point To: ';
		print: referee
]

{ #category : #'as yet unclassified' }
FylgjaCandidateStub >> refersToObjectsLike: aMOPrimitiveType [

	^ aMOPrimitiveType isCollection
		  ifTrue: [ aMOPrimitiveType allSatisfy: [ : a | self refersToObjectsLikeOrStonRef: a ]  ]
		  ifFalse: [ aMOPrimitiveType isDeclaration ]
]
