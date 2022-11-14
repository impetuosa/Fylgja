Class {
	#name : #MoxingTextComposer,
	#superclass : #Object,
	#instVars : [
		'ast',
		'text',
		'model',
		'style'
	],
	#category : #'Fylgja-UI-Text'
}

{ #category : #adding }
MoxingTextComposer >> addAttributeAccessorKind: aSmaCCCaseInsensitiveToken [

	^ self
		  addStyle: style accessorKind
		  forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeAnnotation: aSmaCCToken [ 
	^ self addStyle: style annotation forToken: aSmaCCToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeAs: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style as forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeAssignmentKind: aSmaCCCaseInsensitiveToken [

	^ self
		  addStyle: style assignmentKind
		  forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeCase: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style case forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeClass: aSmaCCToken [

	^ self addStyle: style classStyle forToken: aSmaCCToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeColor: aVBToken [

	^ self addStyle: (style colorForToken: aVBToken) forToken: aVBToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeCompare: aSmaCCCaseInsensitiveToken [ 
	^ self
		  addStyle: style compare
		  forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeConst: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style const forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeDatabase: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style database forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeDim: aSmaCCCaseInsensitiveToken [ 
	^ self
		  addStyle: style dim
		  forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeElse: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style else forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeEndToken: aSmaCCCaseInsensitiveToken [

	^ self
		  addStyle: style endKeyword
		  forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeEnum: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style enum forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeError: aSmaCCCaseInsensitiveToken [ 
	^ self
		  addStyle: style errorStyle
		  forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeExplicit: aSmaCCCaseInsensitiveToken [ 

	^ self
		  addStyle: style explicit
		  forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeExtends: anUndefinedObject [ 
	self addStyle: style extends forToken: anUndefinedObject
]

{ #category : #adding }
MoxingTextComposer >> addAttributeFunction: aSmaCCCaseInsensitiveToken [

	^ self
		  addStyle: style functionKeyword
		  forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeGoTo: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style goto forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeIf: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style if forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeImplements: anUndefinedObject [

	self addStyle: style implements forToken: anUndefinedObject
]

{ #category : #adding }
MoxingTextComposer >> addAttributeImport: aSmaCCToken [ 
	
	self addStyle: style keyword forToken: aSmaCCToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeKeyword: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style keyword forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeLabel: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style label forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeLiteral: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style literal forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeModifier: aJavaModifierNode [ 
	^ self addStyle: style modifier forToken: aJavaModifierNode
]

{ #category : #adding }
MoxingTextComposer >> addAttributeNew: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style new forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeNext: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style next forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeOn: aSmaCCCaseInsensitiveToken [ 
	^ self
		  addStyle: style on
		  forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeOperator: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style operator forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeOption: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style option forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributePackage: aSmaCCToken [

	self addStyle: style package forToken: aSmaCCToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeProperty: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style property forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeResume: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style resume forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeReturn: aSmaCCToken [ 
	^ self addStyle: style return forToken: aSmaCCToken
]

{ #category : #enumerating }
MoxingTextComposer >> addAttributeSelect: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style select forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeStringLiteral: aSmaCCCaseInsensitiveToken [ 
^ self
		  addStyle: style string 
		  forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeSub: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style sub forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeThen: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style then forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeType: aSmaCCCaseInsensitiveToken [ 
	
^ self
		  addStyle: style type
		  forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeVisibility: aSmaCCCaseInsensitiveToken [

	^ self
		  addStyle: style visibility
		  forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addAttributeWith: aSmaCCCaseInsensitiveToken [

	^ self addStyle: style with forToken: aSmaCCCaseInsensitiveToken
]

{ #category : #adding }
MoxingTextComposer >> addColor: aColor forToken: aToken [

	aToken ifNil: [ ^ self ].
	text
		addAttribute: (TextColor new color: aColor)
		from: aToken startPosition
		to: aToken stopPosition
]

{ #category : #adding }
MoxingTextComposer >> addStyle: aStyleArray forToken: aToken [

	aToken ifNil: [ ^ self ].
	aStyleArray do: [ :aStyle | 
		text
			addAttribute: aStyle
			from: (aToken startPosition min: text size)
			to: (aToken stopPosition min: text size) ]
]

{ #category : #'as yet unclassified' }
MoxingTextComposer >> compose: anAst model: aModel style: aStyle into: aText browsingWith: aBrowsingObject [ 

	ast := anAst.
	text := aText. 
	style := aStyle.

	ast acceptVisitor: self.

	^ text
]

{ #category : #'as yet unclassified' }
MoxingTextComposer >> compose: aString parser: aParser model: aModel style: aStyle browsingWith: aBrowsingObject [

	| anAst |
	[ anAst := aParser parse: aString ]
		on: Error
		do: [ :e | self inform: e messageText ].
	anAst ifNil: [ ^ Text fromString: aString ].
	text := Text fromString: aString.

	"AlceTextModelComposer new
		compose: anAst
		model: aModel
		style: aStyle
		into: text
		browsingWith: aBrowsingObject."


	aModel language astComposer new
		compose: anAst
		model: aModel
		style: aStyle
		into: text
		browsingWith: aBrowsingObject.

	^ text
]
