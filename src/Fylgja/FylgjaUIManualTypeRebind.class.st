Class {
	#name : #FylgjaUIManualTypeRebind,
	#superclass : #FylgjaUITransformCommand,
	#category : #'Fylgja-UI-Command-Transform'
}

{ #category : #'accessing - defaults' }
FylgjaUIManualTypeRebind class >> defaultName [

	^ 'Manual Type Bind'
]

{ #category : #testing }
FylgjaUIManualTypeRebind >> canBeExecuted [


	^ self context selectedItems size = 1 and: [ 
		  self context selectedItems allSatisfy: [ :i | 
			  i isInvocable or: [ 
				  i isVariable or: [ 
					  i isTypeReference or: [ 
						  i isFylgjaStub and: [ i parent isTypeReference ] ] ] ] ] ]
]

{ #category : #executing }
FylgjaUIManualTypeRebind >> chooseType: aMOConstantAttribute [

	| objs newType |
	objs := (self context controller fylgja selectDerivativeModelFor:
		         aMOConstantAttribute) allTypes sort:
		        [ :s | s parent name , '.' , s name ] ascending.

	newType := UIManager default
		           chooseFrom:
		           (objs collect: [ :e | e parent name , '.' , e name ])
		           values: objs
		           title: ' Title'.
	^ newType
]

{ #category : #executing }
FylgjaUIManualTypeRebind >> execute [

	self visitCollection: self context selectedItems
]

{ #category : #visiting }
FylgjaUIManualTypeRebind >> visitMethod: aMOMethod [

	| newType |
	newType := self chooseType: aMOMethod.
	newType ifNil: [ ^ self ].
	self apply: [ :method :methodWriter | 
		methodWriter returnTypeReference:
			((methodWriter typeReferenceNamed: newType name)
				 referee: newType;
				 yourself) ]
]

{ #category : #visiting }
FylgjaUIManualTypeRebind >> visitParameter: aMOParameter [

	^ self visitVariable: aMOParameter
]

{ #category : #executing }
FylgjaUIManualTypeRebind >> visitVariable: aMOConstantAttribute [

	| newType  |
	newType := self chooseType: aMOConstantAttribute.
	newType ifNil: [ ^ self ].
	aMOConstantAttribute typeReference referee = newType ifTrue: [ 
		^ self ].

	self apply: [ :var :varWriter | 
		varWriter typeReference:
			((varWriter typeReferenceNamed: newType name)
				 referee: newType;
				 yourself) ]
]
