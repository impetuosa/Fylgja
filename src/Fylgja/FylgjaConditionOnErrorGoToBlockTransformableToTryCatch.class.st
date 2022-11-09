Class {
	#name : #FylgjaConditionOnErrorGoToBlockTransformableToTryCatch,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionOnErrorGoToBlockTransformableToTryCatch >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	| stmt onErrorGoTo |
	
	(aProvenanceEntityRelation to isKindOf: MOBlock) ifFalse: [ ^ false ].
	aProvenanceEntityRelation to statements ifEmpty: [ ^ false ].
	
	onErrorGoTo := aProvenanceEntityRelation to statements
		               detect: [ :a | a isKindOf: MOAlceOnErrorGoToLabel ]
		               ifNone: [ ^ false ].
	stmt := aProvenanceEntityRelation to statements
		        detect: [ :a | 
			        (a isKindOf: MOStatementExpression) and: [ 
				        (a expression isKindOf: MOLabelReference) and: [ 
					        a expression name = onErrorGoTo destination name ] ] ]
		        ifNone: [ ^ false ].

	^ (aProvenanceEntityRelation to statements at:
		   (aProvenanceEntityRelation to statements indexOf: stmt) - 1) 
		  isKindOf: MOAlceExit
]

{ #category : #testing }
FylgjaConditionOnErrorGoToBlockTransformableToTryCatch >> printOn: aStream [

	aStream nextPutAll: 'On Error Go to used as Try/Catch'
]
