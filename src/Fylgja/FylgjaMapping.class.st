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
		nextPutAll: source parent name;
		nextPutAll: '.';
		nextPutAll: source name;
		nextPutAll: ' => ';
		nextPutAll: target parent name;
		nextPutAll: '.';
		nextPutAll: target name
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
FylgjaMapping >> target [

	^ target
]

{ #category : #accessing }
FylgjaMapping >> target: anObject [

	target := anObject
]