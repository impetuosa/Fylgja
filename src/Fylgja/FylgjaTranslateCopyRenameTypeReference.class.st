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
FylgjaTranslateCopyRenameTypeReference >> applyTo: aRelatedProvenanceEntity destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	writer := aDestinationWriter.
	^ aRelatedProvenanceEntity acceptVisitor: self
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

{ #category : #visiting }
FylgjaTranslateCopyRenameTypeReference >> visitTypeReference: aMOTypeReference [

	^ writer typeReferenceNamed: name
]
