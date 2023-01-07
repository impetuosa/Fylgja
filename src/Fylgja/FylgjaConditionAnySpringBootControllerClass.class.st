Class {
	#name : #FylgjaConditionAnySpringBootControllerClass,
	#superclass : #FylgjaCondition,
	#instVars : [
		'annotationNames'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionAnySpringBootControllerClass >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ aProvenanceEntityRelation to isInvocable and: [ 
		  aDestinationContextRelation to isClassLike and: [ 
			  aDestinationContextRelation to annotationInstances anySatisfy: [ 
				  :a | a typeReference name asLowercase = #RestController asLowercase ] ] ]
]
