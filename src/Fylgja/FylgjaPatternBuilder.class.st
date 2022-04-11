Class {
	#name : #FylgjaPatternBuilder,
	#superclass : #Object,
	#instVars : [
		'parse',
		'parser',
		'reader',
		'model'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #parsing }
FylgjaPatternBuilder >> build [

	| ast |
	ast := self getAstFrom: self string parser: self parser.

	reader := self reader new.
	reader model: self model.
	^ FylgjaConditionPattern new
		  node: (reader read: ast);
		  patternString: self string;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaPatternBuilder >> getAstFrom: aString parser: aSmaccParser [

	| errors |
	errors := OrderedCollection new.
	(aSmaccParser class selectors select: [ :s | 
		 s beginsWith: 'startingStateFor' ]) do: [ :selector | 
		[ 
		^ aSmaccParser
			  parse: aString
			  startingAt: (aSmaccParser perform: selector) ]
			on: SmaCCParserError
			do: [ :e | errors add: e ] ].
	self error: ' The string cannot be parsed with the given parser. Check on the error collection for more information '
]

{ #category : #accessing }
FylgjaPatternBuilder >> model [

	^ model ifNil: [ self error: ' A Model must be provided ' ]
]

{ #category : #accessing }
FylgjaPatternBuilder >> model: aMOModel [

	model := aMOModel
]

{ #category : #accessing }
FylgjaPatternBuilder >> parse: aString [ 
	parse := aString
]

{ #category : #parsing }
FylgjaPatternBuilder >> parse: aString parser: aParser reader: aReader [

	| ast |
	ast := self getAstFrom: aString parser: aParser.
	reader := aReader new.
	^ FylgjaConditionPattern new node: (reader read: ast)
]

{ #category : #parsing }
FylgjaPatternBuilder >> parse: aString parser: aParser reader: aReader model: model [ 

	| ast  |
	ast := self getAstFrom: aString parser: aParser.
	
	reader := aReader new.
	reader model: model . 
	^ FylgjaConditionPattern new node: (reader read: ast)
]

{ #category : #accessing }
FylgjaPatternBuilder >> parser [

	^ parser ifNil: [ self error: ' A Parser class must be provided ' ]
]

{ #category : #accessing }
FylgjaPatternBuilder >> parser: aClass [ 
	parser := aClass
]

{ #category : #accessing }
FylgjaPatternBuilder >> reader [
	^ reader ifNil: [ self error: ' A reading class must be provided ' ]
]

{ #category : #accessing }
FylgjaPatternBuilder >> reader: aClass [ 
	reader := aClass
]

{ #category : #accessing }
FylgjaPatternBuilder >> string [

	^ parse ifNil: [ self error: ' a string to parse must be provided ' ]
]
