Class {
	#name : #FylgjaConditionOnErrorGoToBlockTransformableToTryCatch,
	#superclass : #FylgjaCondition,
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionOnErrorGoToBlockTransformableToTryCatch >> matches: aProvenanceEntity context: aDestinationContext [

	| stmt onErrorGoTo |
	(aProvenanceEntity isKindOf: MOBlock) ifFalse: [ ^ false ].
	aProvenanceEntity statements ifEmpty: [ ^ false ].
	onErrorGoTo := aProvenanceEntity statements
		               detect: [ :a | a isKindOf: MOAlceOnErrorGoToLabel ]
		               ifNone: [ ^ false ].
	stmt := aProvenanceEntity statements
		        detect: [ :a | 
			        (a isKindOf: MOStatementExpression) and: [ 
				        (a expression isKindOf: MOAlceLabelReference) and: [ 
					        a expression name = onErrorGoTo destination name ] ] ]
		        ifNone: [ ^ false ].
	^ (aProvenanceEntity statements at:
		   (aProvenanceEntity statements indexOf: stmt) - 1) isKindOf:
		  MOAlceExit
]
