Class {
	#name : #FylgjaNestedMapping,
	#superclass : #FylgjaMapping,
	#instVars : [
		'mappings'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #'as yet unclassified' }
FylgjaNestedMapping >> canBeMapped: aMOParameter from: aCollection [

	^ (self source parameters indexOf: (mappings at: aMOParameter))
	  <= aCollection size
]

{ #category : #'as yet unclassified' }
FylgjaNestedMapping >> choose: aMOParameter from: aCollection [

	^ aCollection at:
		  (self source parameters indexOf: (mappings at: aMOParameter))
]

{ #category : #accessing }
FylgjaNestedMapping >> hasReceiver [

	^ mappings at: #receiver ifPresent: [ true ] ifAbsent: [ false ]
]

{ #category : #'operators-mapping' }
FylgjaNestedMapping >> map: aCollection [

	^ target parameters collect: [ :param | 
		  self choose: param from: aCollection ]
]

{ #category : #'as yet unclassified' }
FylgjaNestedMapping >> mapReceiver: aCollection [

	^ aCollection at: (self source parameters indexOf: self receiver)
]

{ #category : #accessing }
FylgjaNestedMapping >> mappings [

	^ mappings
]

{ #category : #accessing }
FylgjaNestedMapping >> mappings: anObject [

	mappings := anObject
]

{ #category : #accessing }
FylgjaNestedMapping >> mapsArguments [

	^ true
]

{ #category : #'as yet unclassified' }
FylgjaNestedMapping >> mapsArguments: aCollection [

	^ target parameters allSatisfy: [ :param | 
		  self canBeMapped: param from: aCollection ]
]

{ #category : #accessing }
FylgjaNestedMapping >> printOn: aStream [

	| pieces |
	super printOn: aStream.
	pieces := OrderedCollection new.
	mappings keysAndValuesDo: [ :tp :sp | 
		pieces add: ('{1}.{2}.{3} -> {3}.{4}.{5}' format: { 
					 source parent name.
					 source name.
					 sp name.
					 target parent name.
					 target name.
					 tp name }) ].
	aStream
		nextPutAll: '(';
		nextPutAll: (',' join: pieces);
		nextPutAll: ')'
]

{ #category : #accessing }
FylgjaNestedMapping >> receiver [

	^ mappings at: #receiver
]
