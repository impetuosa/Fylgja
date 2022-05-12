Class {
	#name : #FylgjaOperationMultiDispatch,
	#superclass : #FylgjaOperation,
	#instVars : [
		'subdestinations',
		'destinations'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaOperationMultiDispatch >> applyTo: aMODeclarationStructuralRelation croppingRelationsWith: aFullBlockClosure destinationWriter: aMORootDeclarationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

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
FylgjaOperationMultiDispatch >> destinations: aCollection [

	destinations := aCollection
]

{ #category : #accessing }
FylgjaOperationMultiDispatch >> printOn: aStream [

	aStream nextPutAll: 'Re-Dispatch to targets: '.
	destinations do: [ :d | 
		aStream
			print: d;
			nextPutAll: ', ' ]
]
