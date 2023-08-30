"
NestedMapping class.
"
Class {
	#name : #FylgjaNestedMapping,
	#superclass : #FylgjaMapping,
	#instVars : [
		'mappings'
	],
	#category : #'Fylgja-Mappings'
}

{ #category : #'as yet unclassified' }
FylgjaNestedMapping >> canBeMapped: aMOParameter from: aCollection [

	^ (self source parameters indexOf: (mappings at: aMOParameter))
	  <= aCollection size
]

{ #category : #'as yet unclassified' }
FylgjaNestedMapping >> choose: aMOParameter from: aCollection [

	<doc:
	'Given a parameter and a collection, It returns the object of a collection that should be mapped to the given parameter. '>
	^ aCollection at:
		  (self source parameters indexOf: (mappings at: aMOParameter))
]

{ #category : #accessing }
FylgjaNestedMapping >> hasReceiver [

	^ mappings at: #receiver ifPresent: [ true ] ifAbsent: [ false ]
]

{ #category : #testing }
FylgjaNestedMapping >> isEquivalentTo: aFylgjaNestedMapping [

	<doc:
	'It tests if this nested mapping is equivalent to an other mapping. It avoid the redefinition of = to avoid the redefinition of hash.'>
	^ self species = aFylgjaNestedMapping species and: [ 
		  source anchor = aFylgjaNestedMapping source anchor and: [ 
			  source name = aFylgjaNestedMapping source name and: [ 
				  target anchor = aFylgjaNestedMapping target anchor and: [ 
					  target name = aFylgjaNestedMapping target name and: [ 
						  mappings = aFylgjaNestedMapping mappings ] ] ] ] ]
]

{ #category : #'operators-mapping' }
FylgjaNestedMapping >> map: aCollection [

	<doc:
	'Given a collection of arguments, returns a mapped collection them according to the parameter mapping '>
	^ target parameters collect: [ :param | 
		  self choose: param from: aCollection ]
]

{ #category : #'as yet unclassified' }
FylgjaNestedMapping >> mapReceiver: aCollection [

	^ aCollection at: (self source parameters indexOf: self receiver)
]

{ #category : #accessing }
FylgjaNestedMapping >> mappingString [

	| pieces |
	pieces := OrderedCollection new.
	mappings keysAndValuesDo: [ :tp :sp | 
		pieces add: ('{2} -> {4}' format: { 
					 self sourceName.
					 sp name.
					 self targetName.
					 tp name }) ].
	^ super mappingString , '(' , (',' join: pieces) , ')'
]

{ #category : #accessing }
FylgjaNestedMapping >> mappingString2 [

	| pieces |
	pieces := OrderedCollection new.
	mappings keysAndValuesDo: [ :tp :sp | 
		pieces add: ('{2} -> {4}' format: { 
					 self sourceName.
					 sp name.
					 self targetName.
					 tp name }) ].
	^ super mappingString , '(' , (',' join: pieces) , ')'
]

{ #category : #accessing }
FylgjaNestedMapping >> mappings [

	^ mappings
]

{ #category : #accessing }
FylgjaNestedMapping >> mappings: anObject [

	<doc:
	'Sets the nested mappings. The parameter is expected to be a collection of simple mappings. '>
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
		pieces add: ('{2} -> {4}' format: { 
					 self sourceName.
					 sp name.
					 self targetName.
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
