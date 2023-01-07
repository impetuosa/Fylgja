Class {
	#name : #FylgjaOperation,
	#superclass : #Object,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaOperation class >> possibleWritingMessages [

	^ { #writeExpression:. #writeStatement: }
]

{ #category : #'as yet unclassified' }
FylgjaOperation >> booleanTypeReference: aMOClassWriter [

	| boolean |
	boolean := (aMOClassWriter model allEntitiesSelect: [ :a | 
		           a isPrimitiveType and: [ a name = #boolean ] ]) first .
	^ (aMOClassWriter typeReferenceNamed: #boolean)
		  referee: boolean;
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
	typeRef referee: candidate.
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
	typeRef referee: candidate.
	typeRef packageReference: (aWriter packageReferenceNamed: aPackName).
	^ typeRef
]

{ #category : #'as yet unclassified' }
FylgjaOperation >> calculateTypeReference: aString using: aWriter [

	| typeRef candidate parametrizable packRef |
	parametrizable := false.
	candidate := (aWriter model allEntitiesSelect: [ :a | 
		              a isType and: [ a name = aString ] ]) ifEmpty: [ 
		             aWriter model catalogEntitiesSelect: [ :a | 
			             a isType and: [ a name = aString ] ] ].
	candidate := candidate ifEmpty: [ nil ] ifNotEmpty: [ 
		             self assert: candidate size = 1.
		             parametrizable := candidate first isParametrizable.
		             packRef := candidate first packageReference ifNotNil: [ 
			                        :r | aWriter packageReferenceNamed: r name ].
		             candidate first ].
	typeRef := parametrizable
		           ifTrue: [ 
		           aWriter
			           parametrizedTypeReferenceNamed: aString
			           arguments: {  } ]
		           ifFalse: [ aWriter typeReferenceNamed: aString ].
	typeRef referee: candidate.
	typeRef packageReference: packRef.
	^ typeRef
]

{ #category : #testing }
FylgjaOperation >> canWriteOver: aMOPackageWriter [

	^ self possibleWritingMessages anySatisfy: [ :m | 
		  aMOPackageWriter respondsTo: m ]
]

{ #category : #'as yet unclassified' }
FylgjaOperation >> defaultInstanceFor: aProvenanceEntity withIn: model [

	| object |
	object := model objectsSelect: [ :a | 
		          a type class = aProvenanceEntity class and: [ 
			          a type name = aProvenanceEntity name ] ].

	self assert: object size = 1.
	^ object first
]

{ #category : #'as yet unclassified' }
FylgjaOperation >> importableDependencies: aMOClass [

	^ aMOClass dependencies select: [ :a | 
		  a packageReference isNotNil and: [ 
			  a packageReference name ~= 'java.lang' and: [ 
				  a packageReference name ~= 'typescript' and: [ 
					  a packageReference name ~= 'RuntimePrimitiveTypes' ] ] ] ]
]

{ #category : #testing }
FylgjaOperation >> isAdapting [ 
	^ false. 
]

{ #category : #'as yet unclassified' }
FylgjaOperation >> possibleWritingMessages [

	^ self class possibleWritingMessages
]

{ #category : #'instance creation' }
FylgjaOperation >> typeReferenceTo: aDeclaration using: aWriter [

	^ (aWriter typeReferenceNamed: aDeclaration name)
		  referee: aDeclaration;
		  yourself
]

{ #category : #'instance creation' }
FylgjaOperation >> variableReferenceTo: aDeclaration using: aWriter [

	^ (aWriter variableReferenceNamed: aDeclaration name)
		  referee: aDeclaration;
		  yourself
]
