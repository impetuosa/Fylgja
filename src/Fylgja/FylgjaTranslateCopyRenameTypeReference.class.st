Class {
	#name : #FylgjaTranslateCopyRenameTypeReference,
	#superclass : #FylgjaTranslation,
	#instVars : [
		'writer',
		'name'
	],
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyRenameTypeReference class >> possibleWritingMessages [

	^ { #primitiveTypeReferenceNamed:. #typeReferenceNamed: }
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyRenameTypeReference >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| entity |
	writer := aDestinationWriter.
	entity := aRelatedProvenanceEntity to acceptVisitor: self.
	[ 
	^ self
		  applyBindTo: entity
		  withCandidateFrom: aRelatedProvenanceEntity
		  croppingRelationsWith: aBlock
		  writer: aDestinationWriter
		  lookup: aFylgjaLookUpContext
		  using: aFylgjaDerivativeModel ] ensure: [ writer := nil ]
]

{ #category : #testing }
FylgjaTranslateCopyRenameTypeReference >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isTypeReference and: [ 
		  self canWriteOver: aWriter ]
]

{ #category : #accessing }
FylgjaTranslateCopyRenameTypeReference >> name: aName [ 

	name := aName 
]

{ #category : #accessing }
FylgjaTranslateCopyRenameTypeReference >> printOn: aStream [

	aStream
		nextPutAll: 'Rename type reference as ';
		nextPutAll: name
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
