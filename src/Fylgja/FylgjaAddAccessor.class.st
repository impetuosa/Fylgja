Class {
	#name : #FylgjaAddAccessor,
	#superclass : #FylgjaModification,
	#instVars : [
		'attribute'
	],
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #'instance creation' }
FylgjaAddAccessor class >> possibleWritingMessages [

	^ { #writeMethod: }
]

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
	ref referee: attribute.
	^ ref
]

{ #category : #accessing }
FylgjaAddAccessor >> referenceToVarLike: parameter using: block [

	^ (block variableReferenceNamed: parameter name)
		  referee: parameter;
		  yourself
]
