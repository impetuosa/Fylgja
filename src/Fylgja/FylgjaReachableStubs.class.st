Class {
	#name : #FylgjaReachableStubs,
	#superclass : #Object,
	#instVars : [
		'stubs',
		'traversed'
	],
	#category : #'Fylgja-UI'
}

{ #category : #initialization }
FylgjaReachableStubs >> calculate: aDeclaration [

	(traversed includes: aDeclaration) ifTrue: [ ^ self ].
	traversed add: aDeclaration.
	stubs addAll: (aDeclaration allCandidates select: #isFylgjaStub).

	aDeclaration allContainments do: [ :c | self calculate: c ].
	aDeclaration allExpressions do: [ :c | self calculate: c ].
	aDeclaration allReferences do: [ :c | self calculate: c ] 
]

{ #category : #initialization }
FylgjaReachableStubs >> initialize [

	super initialize.
	traversed := Set new.
	stubs := OrderedCollection new
]

{ #category : #initialization }
FylgjaReachableStubs >> stubsFor: aDeclaration [

	self calculate: aDeclaration.
	^ stubs
]
