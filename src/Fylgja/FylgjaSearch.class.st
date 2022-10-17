Class {
	#name : #FylgjaSearch,
	#superclass : #Object,
	#instVars : [
		'node',
		'criteria'
	],
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #'as yet unclassified' }
FylgjaSearch >> anySatisfy: aFullBlockClosure within: aMOBlock [

	criteria := aFullBlockClosure.
	node := aMOBlock.
	^ aMOBlock acceptVisitor: self
]

{ #category : #visiting }
FylgjaSearch >> visitBlock: aMOBlock [

	^ self visitNode: aMOBlock
]

{ #category : #visiting }
FylgjaSearch >> visitCollection: aCollection [

	^ aCollection
		  inject: false
		  into: [ :acc :each | acc or: [ each acceptVisitor: self ] ]
]

{ #category : #visiting }
FylgjaSearch >> visitLocalVariable: aMOLocalVariable [

	^ self visitNode: aMOLocalVariable
]

{ #category : #visiting }
FylgjaSearch >> visitNode: aMOBlock [

	^ (criteria value: aMOBlock)
		  ifTrue: [ ^ true ]
		  ifFalse: [ self visitCollection: aMOBlock allContainments ]
]

{ #category : #visiting }
FylgjaSearch >> visitStatementExpression: aMOObject [

	^ self visitNode: aMOObject
]
