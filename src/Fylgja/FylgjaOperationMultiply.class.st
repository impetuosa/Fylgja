Class {
	#name : #FylgjaOperationMultiply,
	#superclass : #FylgjaOperation,
	#instVars : [
		'subdestinations',
		'destinations'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaOperationMultiply >> applyTo: aMODeclarationStructuralRelation croppingRelationsWith: aFullBlockClosure destinationWriter: aMORootDeclarationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| results |

	results := destinations collect: [ :d | 
		           aFylgjaDerivativeModel
			           produceWithContextualizedProvenance:
			           aMODeclarationStructuralRelation
			           croppingRelationsWith: aFullBlockClosure
			           into: d ].
	^ results
]

{ #category : #accessing }
FylgjaOperationMultiply >> destinations: aCollection [

	destinations := aCollection
]
