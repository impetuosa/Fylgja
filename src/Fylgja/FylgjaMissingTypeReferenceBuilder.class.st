Class {
	#name : #FylgjaMissingTypeReferenceBuilder,
	#superclass : #AnObsoleteMOModelBuilderDelegate,
	#instVars : [
		'type',
		'destinationContext'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #accessing }
FylgjaMissingTypeReferenceBuilder >> destinationContext: aMOClass [

	destinationContext := aMOClass
]

{ #category : #accessing }
FylgjaMissingTypeReferenceBuilder >> privateBuild [

	^ (self instantiate: FylgjaMissingTypeReference)
		  type: type;
		  context: destinationContext;
		  yourself
]

{ #category : #generated }
FylgjaMissingTypeReferenceBuilder >> type: aMOPrimitiveTypeReference [ 
	type := aMOPrimitiveTypeReference 
]
