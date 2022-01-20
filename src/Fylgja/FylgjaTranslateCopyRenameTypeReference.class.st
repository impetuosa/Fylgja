Class {
	#name : #FylgjaTranslateCopyRenameTypeReference,
	#superclass : #FylgjaTranslate,
	#instVars : [
		'writer',
		'name'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyRenameTypeReference >> applyTo: aProvenanceEntity context: aDestinationContext using: aFylgjaDerivativeModel [
	writer := (aFylgjaDerivativeModel selectDestinationModelFor:
		           aDestinationContext) writer.
	^ aProvenanceEntity acceptVisitor: self
]

{ #category : #accessing }
FylgjaTranslateCopyRenameTypeReference >> name: aName [ 
	name := aName 
]

{ #category : #accessing }
FylgjaTranslateCopyRenameTypeReference >> string: aString [ 
	name := aString 
]

{ #category : #accessing }
FylgjaTranslateCopyRenameTypeReference >> visitPrimitiveTypeReference: aMOPrimitiveTypeReference [

	^ writer primitiveTypeReferenceNamed: name
]
