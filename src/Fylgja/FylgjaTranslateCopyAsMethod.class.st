Class {
	#name : #FylgjaTranslateCopyAsMethod,
	#superclass : #FylgjaTranslate,
	#instVars : [
		'writer'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> applyTo: aProvenanceElement context: aDestinationContext using: aFylgjaDerivativeModel [

	| method |
	aFylgjaDerivativeModel
		writerFor: aProvenanceElement
		inContextOf: aDestinationContext
		do: [ :writingEntity :contextWriter | 
			contextWriter writeMethod: [ :methodWriter | 
				methodWriter onBuild: [ :m | method := m ].
				self configure: methodWriter with: aProvenanceElement ] ].

	self
		produceChildren: aProvenanceElement
		into: method
		using: aFylgjaDerivativeModel.
	^ method
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> configure: aMOMethodWriter with: aProvenanceEntity [ 
	writer := aMOMethodWriter.
	aProvenanceEntity acceptVisitor: self
]

{ #category : #printing }
FylgjaTranslateCopyAsMethod >> printOn: aStream [
 	aStream nextPutAll: 'CopyAsMethod'
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> produceChildren: aProvenanceEntity into: aDestinationEntity using: fylgja [

	aProvenanceEntity parameters do: [ :p | 
		fylgja migrate: p into: aDestinationEntity ].
	fylgja migrate: aProvenanceEntity block into: aDestinationEntity.
	(aProvenanceEntity isKindOf: MOFunction) ifTrue: [ 
		| ref |
		ref := fylgja
			       migrate: aProvenanceEntity returnTypeReference
			       into: aDestinationEntity.
		aDestinationEntity returnTypeReference: (fylgja
				 migrate: aProvenanceEntity returnTypeReference
				 into: aDestinationEntity).

		fylgja
			writerFor: nil
			inContextOf: aDestinationEntity block
			do: [ :writingEntity :contextWriter | 
				contextWriter setAddingStatemntsAtFirst.
				contextWriter writeVariable: [ :variable | 
					variable name: aProvenanceEntity selector.
					variable typeReference: ref ] ] ].
	fylgja
		writerFor: nil
		inContextOf: aDestinationEntity block
		do: [ :writingEntity :contextWriter | 
			contextWriter writeStatement: [ :stmt | 
				stmt return: [ :expression | 
					expression variableReferenceNamed: aProvenanceEntity selector ] ] ].
		
		
	aDestinationEntity modifiers: aProvenanceEntity modifiers.
	aDestinationEntity bindingKind: aProvenanceEntity bindingKind.
	aDestinationEntity thrownTypeReferences:
		(aProvenanceEntity thrownTypeReferences collect: [ :tr | 
			 fylgja migrate: tr into: aDestinationEntity ])
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
