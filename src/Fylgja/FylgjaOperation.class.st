Class {
	#name : #FylgjaOperation,
	#superclass : #Object,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaOperation >> booleanTypeReference: aMOClassWriter [

	| boolean |
	boolean := (aMOClassWriter model allEntitiesSelect: [ :a | 
		           a isPrimitiveType and: [ a name = #boolean ] ]) first .
	^ (aMOClassWriter typeReferenceNamed: #boolean)
		  candidate: boolean;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaOperation >> calculateParametrizableTypeReference: aString packageName: aPackName using: aWriter [

	| typeRef candidate |
	candidate := (aWriter model allEntitiesSelect: [ :a | 
		              a isType and: [ 
			              a name = aString and: [ 
				              a packageReference name = aPackName ] ] ]) ifEmpty: [ 
		             aWriter model catalogEntitiesSelect: [ :a | 
			             a isType and: [ 
				             a name = aString and: [ 
					             a packageReference name = aPackName ] ] ] ].
	candidate := candidate
		             ifEmpty: [ nil ]
		             ifNotEmpty: [ candidate first ].
	typeRef := aWriter
		           parametrizedTypeReferenceNamed:aString
		           arguments: {  }.
	typeRef candidate: candidate.
	typeRef packageReference: (aWriter packageReferenceNamed: aPackName).
	^ typeRef
]

{ #category : #'as yet unclassified' }
FylgjaOperation >> calculateTypeReference: aString packageName: aPackName using: aWriter [

	| typeRef candidate parametrizable |
	parametrizable := false.
	candidate := (aWriter model allEntitiesSelect: [ :a | 
		              a isType and: [ 
			              a name = aString and: [ 
				              a packageReference name = aPackName ] ] ]) ifEmpty: [ 
		             aWriter model catalogEntitiesSelect: [ :a | 
			             a isType and: [ 
				             a name = aString and: [ 
					             a packageReference name = aPackName ] ] ] ].
	candidate := candidate ifEmpty: [ nil ] ifNotEmpty: [ 
		             parametrizable := candidate first isParametrizable.
		             candidate first ].
	typeRef := parametrizable
		           ifTrue: [ 
			           aWriter
				           parametrizedTypeReferenceNamed: aString
				           arguments: {  } ]
		           ifFalse: [ aWriter typeReferenceNamed: aString ].
	typeRef candidate: candidate.
	typeRef packageReference: (aWriter packageReferenceNamed: aPackName).
	^ typeRef
]

{ #category : #testing }
FylgjaOperation >> isBinding [ 
	^ false. 
]

{ #category : #'instance creation' }
FylgjaOperation >> variableReferenceTo: aDeclaration using: aWriter [

	^ (aWriter variableReferenceNamed: aDeclaration name)
		  candidate: aDeclaration;
		  yourself
]

{ #category : #writing }
FylgjaOperation >> writeCopyOf: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ MOModelWriteTypeBasedCopyResolver new
		  resolveWriterFor: aProvenanceEntityRelation
		  writingContext: aDestinationWriter
		  do: [ :elementWriter | 
			  elementWriter
				  writeCopyOf: aProvenanceEntityRelation
				  croppingRelationsWith: aBlock
				  readingValues: [ :contextWriter :value | 
					  aFylgjaDerivativeModel
						  migrate: value
						  croppingRelationsWith: aBlock
						  intoDestinationWriter: contextWriter
						  lookUp: aFylgjaLookUpContext ]
				  bindingWithCandidates: [ 
					  :contextWriter 
					  :provenanceEntityCandidate 
					  :destinationEntity | 
					  aFylgjaDerivativeModel
						  bindAndReturnEntity: destinationEntity
						  as: provenanceEntityCandidate
						  croppingRelationsWith: aBlock
						  usingWriter: contextWriter
						  lookUp: aFylgjaLookUpContext ] ]
]
