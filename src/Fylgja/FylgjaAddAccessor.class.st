Class {
	#name : #FylgjaAddAccessor,
	#superclass : #FylgjaProduction,
	#instVars : [
		'attribute'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #accessing }
FylgjaAddAccessor >> attribute: aMOAttribute [ 
	attribute := aMOAttribute
]

{ #category : #accessing }
FylgjaAddAccessor >> attributeReference: aWriter [

	| ref |
	ref := aWriter writeUnregisteredExpression: [ : uexp | 
		       uexp
			       accessAttribute: attribute name
			       receiver: [ : exp | exp referenceToSelf ] ].
	ref candidate: attribute.
	^ ref
]

{ #category : #accessing }
FylgjaAddAccessor >> referenceToVarLike: parameter using: block [

	^ (block variableReferenceNamed: parameter name)
		  candidate: parameter;
		  yourself
]
