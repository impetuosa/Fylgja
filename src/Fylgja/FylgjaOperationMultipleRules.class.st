Class {
	#name : #FylgjaOperationMultipleRules,
	#superclass : #FylgjaOperation,
	#instVars : [
		'operations'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaOperationMultipleRules >> applyTo: aMODeclarationStructuralRelation croppingRelationsWith: aFullBlockClosure destinationWriter: aMOAngularModuleWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ operations collect: [ :op | 
		  op
			  applyTo: aMODeclarationStructuralRelation
			  croppingRelationsWith: aFullBlockClosure
			  destinationWriter: aMOAngularModuleWriter
			  lookUp: aFylgjaLookUpContext
			  using: aFylgjaDerivativeModel ]
]

{ #category : #accessing }
FylgjaOperationMultipleRules >> operations: aCollection [ 
	operations := aCollection
]

{ #category : #accessing }
FylgjaOperationMultipleRules >> printOn: aStream [

	aStream nextPutAll: 'Apply Ops : '.
	operations do: [ :d | 
		aStream
			print: d;
			nextPutAll: ', ' ]
]
