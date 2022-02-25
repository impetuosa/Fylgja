Class {
	#name : #FylgjaTranslateCopyAsMethod,
	#superclass : #FylgjaTranslate,
	#instVars : [
		'writer'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> applyTo: aRelatedProvenanceEntity destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ aDestinationWriter writeMethod: [ :methodWriter | 
		  writer := methodWriter.
		  aRelatedProvenanceEntity acceptVisitor: self.
		  methodWriter
			  writeCopyOf: aRelatedProvenanceEntity
			  readingValues: [ :context :value | 
				  aFylgjaDerivativeModel
					  migrate: value
					  intoDestinationWriter: methodWriter
					  lookUp: aFylgjaLookUpContext ] ]
]

{ #category : #printing }
FylgjaTranslateCopyAsMethod >> printOn: aStream [
 	aStream nextPutAll: 'CopyAsMethod'
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> shouldBeProcessed: anObject [

	^ (anObject isKindOf: MOObject) and: [ 
		  (anObject isKindOf: MOLanguage) not ]
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> shouldBeSet: anObject [

	^ (anObject isKindOf: MOLanguage) not and: [ 
		  (anObject isKindOf: JinAnchor) not and: [ anObject isNotNil ] ]
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitFunction: aMOFunction [

	writer selector: aMOFunction selector.
	writer returnTypeReference:
		(writer typeReferenceNamed: aMOFunction returnTypeReference name).
	
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitMethod: aMOMethod [ 
	self shouldBeImplemented.
]

{ #category : #visiting }
FylgjaTranslateCopyAsMethod >> visitProcedure: aMOProcedure [

	writer selector: aMOProcedure selector.
	writer returnTypeReference: (writer typeReferenceNamed: #void)
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> with: anInstanceVariableSlot write: anUndefinedObject to: aMOVariable [ 
	aMOVariable perform: anInstanceVariableSlot name,':' withArguments: { anUndefinedObject  }
]
