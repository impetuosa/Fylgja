Class {
	#name : #FylgjaOperationMultipleProductions,
	#superclass : #FylgjaProduction,
	#instVars : [
		'operations'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaOperationMultipleProductions >> applyTo: aMODeclarationStructuralRelation croppingRelationsWith: aFullBlockClosure destinationWriter: aMOAngularModuleWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ operations collect: [ :op | 
		  op
			  applyTo: aMODeclarationStructuralRelation
			  croppingRelationsWith: aFullBlockClosure
			  destinationWriter: aMOAngularModuleWriter
			  lookUp: aFylgjaLookUpContext
			  using: aFylgjaDerivativeModel ]
]

{ #category : #'as yet unclassified' }
FylgjaOperationMultipleProductions >> canBeAppliedTo: aMODeclarationStructuralRelation context: aMONullDeclarationRelation forProducing: aClass with: aMORootDeclarationWriter [

	^ operations allSatisfy: [ :o | 
		  o
			  canBeAppliedTo: aMODeclarationStructuralRelation
			  context: aMONullDeclarationRelation
			  forProducing: aClass
			  with: aMORootDeclarationWriter ]
]

{ #category : #accessing }
FylgjaOperationMultipleProductions >> operations: aCollection [ 
	operations := aCollection
]

{ #category : #accessing }
FylgjaOperationMultipleProductions >> printOn: aStream [

	aStream nextPutAll: 'Apply Ops : '.
	operations do: [ :d | 
		aStream
			print: d;
			nextPutAll: ', ' ]
]
