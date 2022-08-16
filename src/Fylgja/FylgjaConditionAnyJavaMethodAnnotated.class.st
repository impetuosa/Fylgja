Class {
	#name : #FylgjaConditionAnyJavaMethodAnnotated,
	#superclass : #FylgjaCondition,
	#instVars : [
		'annotationNames'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionAnyJavaMethodAnnotated >> annotationNames: names [

	annotationNames := names
]

{ #category : #testing }
FylgjaConditionAnyJavaMethodAnnotated >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ aProvenanceEntityRelation to isInvocable and: [ 
		  aProvenanceEntityRelation to annotationInstances anySatisfy: [ 
			  :annotation | annotationNames includes: annotation typeReference name ] ]
]
