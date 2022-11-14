Class {
	#name : #FylgjaUIDeclarationCommand,
	#superclass : #FylgjaUICommand,
	#category : #'Fylgja-UI-Command-Model'
}

{ #category : #accessing }
FylgjaUIDeclarationCommand >> apply: aBlock [

	| elementRelation destinationModel |
	^ self context controller
		  applyCommand: self
		  informing: self context
		  do: [ 
			  self assert: self context selectedItems size = 1.
			  elementRelation := self context controller fylgja 
				                     readEntitysContextualizingRelation:
				                     self context selectedItems first.
			  destinationModel := self context controller fylgja 
				                      selectDerivativeModelFor:
				                      self context selectedItems first.
			  destinationModel writer
				  updaterFor: elementRelation
				  with: elementRelation
				  do: aBlock ]
]

{ #category : #accessing }
FylgjaUIDeclarationCommand >> fylgja [

	^ self context controller fylgja
]
