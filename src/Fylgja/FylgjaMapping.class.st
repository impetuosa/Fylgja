Class {
	#name : #FylgjaMapping,
	#superclass : #Object,
	#instVars : [
		'source',
		'target'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaMapping >> hasReceiver [

	^ false
]

{ #category : #testing }
FylgjaMapping >> isInvocable [

	^ false
]

{ #category : #testing }
FylgjaMapping >> isInvocation [

	^ false
]

{ #category : #testing }
FylgjaMapping >> isStatement [

	^ false
]

{ #category : #testing }
FylgjaMapping >> isStatementExpression [

	^ false
]

{ #category : #testing }
FylgjaMapping >> isTypeReference [

	^ false
]

{ #category : #testing }
FylgjaMapping >> isVariable [

	^ false
]

{ #category : #accessing }
FylgjaMapping >> mappingString [
	 ^ self targetName 
]

{ #category : #'as yet unclassified' }
FylgjaMapping >> mapsArguments [

	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
FylgjaMapping >> mapsSource: aMOLocalVariable [

	^ source isSameEntity: aMOLocalVariable
]

{ #category : #accessing }
FylgjaMapping >> printOn: aStream [

	aStream
		nextPutAll: self sourceName;
		nextPutAll: ' => ';
		nextPutAll: self targetName
]

{ #category : #accessing }
FylgjaMapping >> source [

	^ source
]

{ #category : #accessing }
FylgjaMapping >> source: anObject [

	source := anObject
]

{ #category : #accessing }
FylgjaMapping >> sourceName [

	| parentName |
	parentName := (source parent respondsTo: #name)
		              ifFalse: [ source parent printString ]
		              ifTrue: [ 
			              (source parent name
				               includesSubstring: 'paper'
				               caseSensitive: false)
				              ifTrue: [ #VBALang ]
				              ifFalse: [ source parent name ] ].


	^ String streamContents: [ :str | 
		  str
			  nextPutAll: (source isType
					   ifTrue: [ 'T' ]
					   ifFalse: [ 
						   (source isKindOf: MOInvocable)
							   ifTrue: 'I'
							   ifFalse: 'V' ]);
			  nextPutAll: ';'.
		  str
			  nextPutAll: parentName;
			  nextPutAll: '.';
			  nextPutAll: source name ]
]

{ #category : #accessing }
FylgjaMapping >> target [

	^ target
]

{ #category : #accessing }
FylgjaMapping >> target: anObject [

	target := anObject
]

{ #category : #accessing }
FylgjaMapping >> targetName [

	^ String streamContents: [ :str | 
					str nextPutAll: (
		  target isType ifTrue: ['T'] ifFalse: [(source isKindOf: MOInvocable) ifTrue:'I' ifFalse: 'V' ]) ; nextPutAll:';' . 
		  str
			  nextPutAll: target parent name;
			  nextPutAll: '.';
			  nextPutAll: target name ]
]
