Class {
	#name : #FylgjaUITransformCommand,
	#superclass : #FylgjaUICommand,
	#category : #'Fylgja-UI-Command-Transform'
}

{ #category : #executing }
FylgjaUITransformCommand >> apply: aBlock [

	| elementRelation destinationModel |
	^ self context controller
		  applyCommand: self
		  informing: self context
		  do: [ 
			  elementRelation := self context controller fylgja 
				                     readEntitysContextualizingRelation:
				                     self selectedItem.
			  destinationModel := self context controller fylgja 
				                      selectDerivativeModelFor: self selectedItem.
			  destinationModel writer
				  updaterFor: elementRelation
				  with: elementRelation
				  do: aBlock ]
]

{ #category : #executing }
FylgjaUITransformCommand >> selectedItem [

	self assert: self context selectedItems size = 1.
	^ self context selectedItems first
]

{ #category : #visiting }
FylgjaUITransformCommand >> visitAttribute: aMOAttribute [

	^ self visitVariable: aMOAttribute
]

{ #category : #visiting }
FylgjaUITransformCommand >> visitCollection: aCollection [

	^ aCollection collect: [ :a | a acceptVisitor: self ]
]

{ #category : #visiting }
FylgjaUITransformCommand >> visitConstantAttribute: aMOConstantAttribute [

	^ self visitVariable: aMOConstantAttribute
]
