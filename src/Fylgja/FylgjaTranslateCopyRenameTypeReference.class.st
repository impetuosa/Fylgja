Class {
	#name : #FylgjaTranslateCopyRenameTypeReference,
	#superclass : #FylgjaTranslate,
	#instVars : [
		'name',
		'writer'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyRenameTypeReference >> applyTo: aMOPrimitiveTypeReference context: aMOVariableArgumentsParameter using: aFylgjaDerivativeModel [

	writer := (aFylgjaDerivativeModel selectDestinationModelFor:
		           aMOVariableArgumentsParameter) writer.
	^ aMOPrimitiveTypeReference acceptVisitor: self
]

{ #category : #accessing }
FylgjaTranslateCopyRenameTypeReference >> name: aString [ 
	name := aString 
]

{ #category : #visiting }
FylgjaTranslateCopyRenameTypeReference >> visitPrimitiveTypeReference: aMOPrimitiveTypeReference [

	^ writer primitiveTypeReferenceNamed: name
]
