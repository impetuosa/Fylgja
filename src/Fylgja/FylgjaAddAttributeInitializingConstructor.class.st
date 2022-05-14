Class {
	#name : #FylgjaAddAttributeInitializingConstructor,
	#superclass : #FylgjaAddConstructor,
	#instVars : [
		'attributes'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #accessing }
FylgjaAddAttributeInitializingConstructor >> attributes: aCollection [ 
	attributes := aCollection
]

{ #category : #'instance creation' }
FylgjaAddAttributeInitializingConstructor >> privateApplyOn: aMOClassWriter [

	| parameters |
	^ aMOClassWriter writeConstructor: [ :constructor | 
		  parameters := attributes collect: [ :a | 
			                constructor writeParameter: [ :param | 
				                param
					                name: 'input' , a name capitalized;
					                typeReference: a typeReference ] ].

		  constructor writeBlock: [ :block | 
			  attributes with: parameters do: [ :a :p | 
				  block writeExpressionStatement: [ :stmt | 
					  stmt writeExpression: [ :exp | 
						  exp
							  let: [ :var | self variableReferenceTo: a using: var ]
							  beAssignedWith: [ :var | 
							  self variableReferenceTo: p using: var ] ] ] ] ] ]
]
