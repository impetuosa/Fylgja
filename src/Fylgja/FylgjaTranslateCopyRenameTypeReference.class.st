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
FylgjaTranslateCopyRenameTypeReference >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| entity |
	writer := aDestinationWriter.
	entity := aRelatedProvenanceEntity to acceptVisitor: self.
	^ self
		  applyBindTo: entity
		  withCandidateFrom: aRelatedProvenanceEntity
		  croppingRelationsWith: aBlock
		  writer: aDestinationWriter
		  lookup: aFylgjaLookUpContext
		  using: aFylgjaDerivativeModel
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
