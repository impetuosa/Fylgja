Class {
	#name : #FylgjaUIInferTypeByDefaultValue,
	#superclass : #FylgjaUITransformCommand,
	#category : #'Fylgja-UI-Command-Transform'
}

{ #category : #'accessing - defaults' }
FylgjaUIInferTypeByDefaultValue class >> defaultName [

	^ 'Guess Type From Initializer'
]

{ #category : #testing }
FylgjaUIInferTypeByDefaultValue >> canBeExecuted [

	^ self context selectedItems size = 1 and: [ 
		  self context selectedItems allSatisfy: [ :i | 
			  i isVariable and: [ i initializer isNotNil ] ] ]
]

{ #category : #executing }
FylgjaUIInferTypeByDefaultValue >> execute [

	self visitCollection: self context selectedItems
]

{ #category : #visiting }
FylgjaUIInferTypeByDefaultValue >> visitVariable: aMOConstantAttribute [

	| newType |
	newType := aMOConstantAttribute initializer type.
	newType ifNil: [ ^ self ].
	aMOConstantAttribute typeReference referee = newType ifTrue: [ 
		^ self ].

	self apply: [ :var :varWriter | 
		varWriter typeReference:
			((varWriter typeReferenceNamed: newType name)
				 referee: newType;
				 yourself) ]
]
