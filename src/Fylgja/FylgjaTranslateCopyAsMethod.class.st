Class {
	#name : #FylgjaTranslateCopyAsMethod,
	#superclass : #FylgjaTranslate,
	#instVars : [
		'writer'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> applyTo: element context: aMethod using: aFylgjaDerivativeModel [

	| method |
	aFylgjaDerivativeModel
		writerFor: element
		inContextOf: aMethod
		do: [ :writingEntity :contextWriter | 
			contextWriter writeMethod: [ :methodWriter | 
				methodWriter onBuild: [ :m | method := m ].
				self configure: methodWriter with: element ] ].

	self
		produceChildren: element
		into: method
		using: aFylgjaDerivativeModel.
	^ method
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> configure: aMOMethodWriter with: aMOFunction [ 
	writer := aMOMethodWriter.
	aMOFunction acceptVisitor: self
]

{ #category : #printing }
FylgjaTranslateCopyAsMethod >> printOn: aStream [
 	aStream nextPutAll: 'CopyAsMethod'
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> produceChildren: aFunction into: aMethod using: fylgja [

	aFunction parameters do: [ :p | fylgja migrate: p into: aMethod ].
	aMethod returnTypeReference:
		(fylgja produce: aFunction returnTypeReference into: aMethod).

	fylgja produce: aFunction block into: aMethod.
	aMethod modifiers: aFunction modifiers.
	aMethod modifiers add: #static. 
	aMethod thrownTypeReferences:
		(aFunction thrownTypeReferences collect: [ :tr | 
			 fylgja produce: tr into: aMethod ])
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

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsMethod >> with: anInstanceVariableSlot write: anUndefinedObject to: aMOVariable [ 
	aMOVariable perform: anInstanceVariableSlot name,':' withArguments: { anUndefinedObject  }
]
