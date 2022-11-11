Class {
	#name : #FylgjaConditionPattern,
	#superclass : #FylgjaCondition,
	#instVars : [
		'node',
		'pairs',
		'patternString'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaConditionPattern class >> priority [

	^ 5
]

{ #category : #accessing }
FylgjaConditionPattern >> initialize [

	super initialize.
	pairs := Dictionary new
]

{ #category : #'as yet unclassified' }
FylgjaConditionPattern >> matchPattern: aPatternNode with: aNode [

	| values |
	((aPatternNode isKindOf: JinAnchor) or: [ 
		 (aPatternNode isKindOf: MOAnchor) or: [ 
			 aPatternNode isKindOf: MOLanguage ] ]) ifTrue: [ 
		self pairs
			at: { 
					aPatternNode.
					aNode } asSet
			put: true.
		^ true ].

	aPatternNode species = aNode species ifFalse: [ 
		self halt.
		^ false ].
	self pairs
		at: { 
				aPatternNode.
				aNode } asSet
		ifPresent: [ :v | ^ v ].


	(aPatternNode isKindOf: MOObject) ifTrue: [ 
		^ aPatternNode class allSlots allSatisfy: [ :s | 
			  self matchPattern: (s read: aPatternNode) with: (s read: aNode) ] ].
	^ self matchValue: aPatternNode with: aNode
]

{ #category : #'as yet unclassified' }
FylgjaConditionPattern >> matchString: aString with: aString2 [

	^ aString = '$' or: [ aString = aString2 ]
]

{ #category : #'as yet unclassified' }
FylgjaConditionPattern >> matchValue: anUndefinedObject with: anUndefinedObject2 [

	^ pairs
		  at: { 
				  anUndefinedObject.
				  anUndefinedObject2 } asSet
		  ifAbsentPut: [ 
			  anUndefinedObject2 species = anUndefinedObject species
				  ifTrue: [ 
					  (anUndefinedObject2 isKindOf: String)
						  ifTrue: [ 
						  self matchString: anUndefinedObject with: anUndefinedObject2 ]
						  ifFalse: [ anUndefinedObject = anUndefinedObject2 ] ]
				  ifFalse: [ false ] ]
]

{ #category : #testing }
FylgjaConditionPattern >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [
self halt .
	^ self matchPattern: node with: aProvenanceEntityRelation to
]

{ #category : #accessing }
FylgjaConditionPattern >> node: aMOVariable [ 
	node := aMOVariable
]

{ #category : #accessing }
FylgjaConditionPattern >> pairs [
	^ pairs
]

{ #category : #accessing }
FylgjaConditionPattern >> patternString: aString [ 
	patternString := aString
]

{ #category : #accessing }
FylgjaConditionPattern >> printOn: aStream [

	aStream nextPutAll: 'matches pattern: (' , patternString , ')'
]
