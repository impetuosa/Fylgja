Class {
	#name : #FylgjaConditionAnyTypescriptClassDecorated,
	#superclass : #FylgjaCondition,
	#instVars : [
		'decoratorNames'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #testing }
FylgjaConditionAnyTypescriptClassDecorated >> decoratorNames: names [

	decoratorNames := names
]

{ #category : #testing }
FylgjaConditionAnyTypescriptClassDecorated >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [

	^ aDestinationContextRelation to isClassLike and: [ 
		  aDestinationContextRelation to decorators anySatisfy: [ :decorator | 
			  decoratorNames includes: decorator typeReference name ] ]
]
