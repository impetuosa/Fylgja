Class {
	#name : #FylgjaUIManualRemoveStatement,
	#superclass : #FylgjaUITransformCommand,
	#category : #'Fylgja-UI-Command-Transform'
}

{ #category : #'accessing - defaults' }
FylgjaUIManualRemoveStatement class >> defaultName [

	^ 'Remove Statement'
]

{ #category : #executing }
FylgjaUIManualRemoveStatement >> applyOnParent: aBlock [

	| elementRelation destinationModel |
	^ self context selectedItems collect: [ :item | 
		  self context controller
			  applyCommand: self
			  informing: self context
			  do: [ 
				  elementRelation := self context controller fylgja 
					                     readEntitysContextualizingRelation:
					                     item parent.
				  destinationModel := self context controller fylgja 
					                      selectDerivativeModelFor: item parent.
				  destinationModel writer
					  updaterFor: elementRelation
					  with: elementRelation
					  do: [ :i :w | aBlock value: item value: i value: w ] ] ]
]

{ #category : #executing }
FylgjaUIManualRemoveStatement >> canBeExecuted [

	^ self context selectedItems allSatisfy: #isStatement
]

{ #category : #executing }
FylgjaUIManualRemoveStatement >> execute [

	self applyOnParent: [ :statement :stList :stListWriter | 
		stListWriter remove: statement ]
]

{ #category : #executing }
FylgjaUIManualRemoveStatement >> selectedItem [

	self assert: self context selectedItems size = 1.
	^ self context selectedItems first parent
]

{ #category : #executing }
FylgjaUIManualRemoveStatement >> statement [

	^ self context selectedItems first
]
