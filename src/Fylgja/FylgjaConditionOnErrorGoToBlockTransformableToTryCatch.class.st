Class {
	#name : #FylgjaConditionOnErrorGoToBlockTransformableToTryCatch,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionOnErrorGoToBlockTransformableToTryCatch >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [

	| stmt onErrorGoTo |
	
	(aProvenanceEntityRelation to isKindOf: MOBlock) ifFalse: [ ^ false ].
	aProvenanceEntityRelation to statements ifEmpty: [ ^ false ].
	
	onErrorGoTo := aProvenanceEntityRelation to statements
		               detect: [ :a | a isKindOf: MOAlceOnErrorGoToLabel ]
		               ifNone: [ ^ false ].
	stmt := aProvenanceEntityRelation to statements
		        detect: [ :a | 
			        (a isKindOf: MOStatementExpression) and: [ 
				        (a expression isKindOf: MOAlceLabelReference) and: [ 
					        a expression name = onErrorGoTo destination name ] ] ]
		        ifNone: [ ^ false ].

	^ (aProvenanceEntityRelation to statements at:
		   (aProvenanceEntityRelation to statements indexOf: stmt) - 1) 
		  isKindOf: MOAlceExit
]
