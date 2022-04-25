Class {
	#name : #MoxingMicrosoftAccessAstComposer,
	#superclass : #MoxingTextComposer,
	#traits : 'TVBProgramNodeVisitor',
	#classTraits : 'TVBProgramNodeVisitor classTrait',
	#category : #'Fylgja-UI-Text'
}

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitArgumentList: anArgumentList [
	^ self visitProgram: anArgumentList
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitAsTypeAndNew: anAsTypeAndNew [

	self addAttributeAs: anAsTypeAndNew aSToken .
	self addAttributeNew: anAsTypeAndNew nEWToken .
	
	^ self visitProgram: anAsTypeAndNew
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitCase: aCase [

	self addAttributeCase: aCase caseToken.
	self addAttributeElse: aCase elseToken.
	^ self visitProgram: aCase
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitColorLiteral: aColorLiteral [

	self addAttributeColor: aColorLiteral token.

	^ self visitProgram: aColorLiteral
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitConcatenationOperation: aConcatenationOperation [

	self addAttributeOperator: aConcatenationOperation andToken.

	^ self visitProgram: aConcatenationOperation
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitConstant: aConstant [
	self addAttributeOperator: aConstant equalToken .
	^ self visitProgram: aConstant
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitConstantList: aConstantList [

	^ self visitProgram: aConstantList
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitDefineEnum: aDefineEnum [

	aDefineEnum enumTokens do: [ :e | self addAttributeEnum: e ].
	self addAttributeVisibility: aDefineEnum visibility.
	self addAttributeEndToken: aDefineEnum endToken.
	^ self visitProgram: aDefineEnum
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitDefineType: aDefineType [

	self addAttributeVisibility: aDefineType visibility.

	aDefineType typeTokens do: [ :t | self addAttributeType: t ].
	self addAttributeEndToken: aDefineType endToken.
	^ self visitProgram: aDefineType
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitDimMultipleVariables: aDimMultipleVariables [

	self addAttributeDim: aDimMultipleVariables dimToken.

	^ self visitProgram: aDimMultipleVariables
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitDimVariable: aDimVariable [

	self addAttributeDim: aDimVariable dimToken.
	^ self visitProgram: aDimVariable
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitDoEvents: aDoEvents [

	self addAttributeKeyword: aDoEvents doEventsToken.
	^ self visitProgram: aDoEvents
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitDoUntilTrue: aDoUntilTrue [

	^ self visitProgram: aDoUntilTrue
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitDoWhileTrue: aDoWhileTrue [

	self addAttributeKeyword: aDoWhileTrue doToken.
	self addAttributeKeyword: aDoWhileTrue loopToken.
	self addAttributeKeyword: aDoWhileTrue whileToken.

	^ self visitProgram: aDoWhileTrue
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitElseIfBlock: anElseIfBlock [

	self addAttributeElse: anElseIfBlock elseifToken.
	self addAttributeElse: anElseIfBlock elseToken.
	self addAttributeThen: anElseIfBlock thenToken.
	^ self visitProgram: anElseIfBlock
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitEnumEntry: anEnumEntry [
 	self addAttributeOperator: anEnumEntry equalToken.
	^ self visitProgram: anEnumEntry
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitEquals: anEquals [
	self addAttributeOperator: anEquals operator.
	
	^ self visitProgram: anEquals
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitEvent: anEvent [

	self addAttributeFunction: anEvent eventToken.

	^ self visitProgram: anEvent
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitExits: anExits [

	{ #exitToken. #functionToken. #subToken. #doToken. #fORToken.
	#propertyToken } do: [ :t | 
		self addAttributeKeyword: (anExits perform: t) ].
	^ self visitProgram: anExits
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitExplicitAssignement: anExplicitAssignement [

	self addAttributeOperator: anExplicitAssignement operator.   
	self addAttributeAssignmentKind: anExplicitAssignement kind.

	^ self visitProgram: anExplicitAssignement
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitExplicitCall: anExplicitCall [

	self addAttributeKeyword: anExplicitCall callToken.
	^ self visitProgram: anExplicitCall
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitExternalFunction: anExternalFunction [
	self addAttributeKeyword: anExternalFunction libToken .
	self addAttributeVisibility: anExternalFunction visibility .
	self addAttributeKeyword: anExternalFunction aliasToken.
	^ self visitProgram: anExternalFunction
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitExternalSub: anExternalSub [

	self addAttributeKeyword: anExternalSub libToken.
	self addAttributeVisibility: anExternalSub visibility.
	self addAttributeKeyword: anExternalSub aliasToken.
	^ self visitProgram: anExternalSub
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitFloatLiteral: aFloatLiteral [

	self addAttributeStringLiteral: aFloatLiteral token.
	^ self visitProgram: aFloatLiteral
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitForEach: aForEach [

	self addAttributeKeyword: aForEach fORToken.
	self addAttributeKeyword: aForEach eachToken.
	self addAttributeKeyword: aForEach inToken.
	self addAttributeNext: aForEach nextToken.
	^ self visitProgram: aForEach
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitForNext: aForNext [
	self addAttributeKeyword: aForNext fORToken.
	self addAttributeKeyword: aForNext toToken.
	self addAttributeNext: aForNext nextToken.
	self addAttributeOperator: aForNext equalToken .
	^ self visitProgram: aForNext
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitForStepNext: aForStepNext [

	self addAttributeKeyword: aForStepNext fORToken.
	self addAttributeKeyword: aForStepNext toToken.
	self addAttributeNext: aForStepNext nextToken.
	self addAttributeKeyword: aForStepNext stepToken .
	self addAttributeOperator: aForStepNext equalToken .
	
	^ self visitProgram: aForStepNext
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitFunctionDefinition: aFunctionDefinition [

	self assert: aFunctionDefinition modifier isNil. 
	self addAttributeVisibility: aFunctionDefinition visibility.
	

	aFunctionDefinition functionTokens do: [ :t | 
		self addAttributeFunction: t ].
	self addAttributeEndToken: aFunctionDefinition endToken.


	^ self visitProgram: aFunctionDefinition
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitGoSub: aGoSub [
	self addAttributeKeyword: aGoSub gosubToken .
	
	^ self visitProgram: aGoSub
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitGoSubLabel: aGoSubLabel [

self halt.
	
	^ self visitProgram: aGoSubLabel
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitGoToStatement: aGoToStatement [

	self addAttributeGoTo: aGoToStatement gotoToken.
	^ self visitProgram: aGoToStatement
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitIfThenElse: anIfThenElse [

	anIfThenElse ifTokens do: [ :i | self addAttributeIf: i ].
	self addAttributeEndToken: anIfThenElse endToken.
	self addAttributeThen: anIfThenElse thenToken .
	self addAttributeElse: anIfThenElse elseToken .
	
	^ self visitProgram: anIfThenElse
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitIntegerLiteral: anIntegerLiteral [

	self addAttributeStringLiteral: anIntegerLiteral token.
	^ self visitProgram: anIntegerLiteral
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitLabelTag: aLabelTag [

	self addAttributeLabel: aLabelTag name.
	self addAttributeOperator: aLabelTag colonToken.
	^ self visitProgram: aLabelTag
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitModule: aModule [

	(aModule attributes at: #comments) do: [ :pair | 
		pair second < text size ifTrue: [ 
			style comment do: [ :cs | 
				text addAttribute: cs from: pair first to: pair second ] ] ].

	^ self visitProgram: aModule
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitModuleAttribute: aModuleAttribute [
self halt.
	
	^ self visitProgram: aModuleAttribute
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitModuleConstant: aModuleConstant [
	self addAttributeConst: aModuleConstant constToken .
	self addAttributeVisibility: aModuleConstant visibility .
	^ self visitProgram: aModuleConstant
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitModuleMultipleConstants: aModuleMultipleConstants [
self halt.
	
	^ self visitProgram: aModuleMultipleConstants
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitModuleProperty: aModuleProperty [

	self addAttributeVisibility: aModuleProperty visibility.
	^ self visitProgram: aModuleProperty
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitModulePropertyGet: aModulePropertyGet [

	self addAttributeAccessorKind: aModulePropertyGet getToken.
	self addAttributeAccessorKind: aModulePropertyGet setToken.
	self addAttributeAccessorKind: aModulePropertyGet letToken.
	self addAttributeVisibility: aModulePropertyGet visibility .
	aModulePropertyGet propertyTokens do: [ : p | self addAttributeProperty: p ].
	self addAttributeEndToken: aModulePropertyGet endToken. 
	
	^ self visitProgram: aModulePropertyGet
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitNewClause: aNewClause [

	self addAttributeNew: aNewClause nEWToken .
	^ self visitProgram: aNewClause
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitNull: aNull [
	self addAttributeLiteral: aNull token . 
	^ self visitProgram: aNull
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitOnErrorGoTo: anOnErrorGoTo [

	self addAttributeOn: anOnErrorGoTo onToken.
	self addAttributeError: anOnErrorGoTo eRRORToken.
	^ self visitProgram: anOnErrorGoTo
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitOnErrorResumeNext: anOnErrorResumeNext [

	self addAttributeOn: anOnErrorResumeNext onToken.
	self addAttributeError: anOnErrorResumeNext eRRORToken.
	self addAttributeResume: anOnErrorResumeNext resumeToken.
	self addAttributeNext: anOnErrorResumeNext nextToken.

	^ self visitProgram: anOnErrorResumeNext
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitOnExpressionGo: anOnExpressionGo [
self halt.
	
	^ self visitProgram: anOnExpressionGo
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitOptionCompare: anOptionCompare [
self halt.
	
	^ self visitProgram: anOptionCompare
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitOptionCompareDatabase: anOptionCompareDatabase [
		
	self addAttributeOption: anOptionCompareDatabase optionToken. 
	self addAttributeCompare: anOptionCompareDatabase compareToken . 
	self addAttributeDatabase: anOptionCompareDatabase databaseToken . 
	^ self visitProgram: anOptionCompareDatabase
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitOptionExplicit: anOptionExplicit [

	self addAttributeOption: anOptionExplicit optionToken.
	self addAttributeExplicit: anOptionExplicit explicitToken.

	^ self visitProgram: anOptionExplicit
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitParameter: aParameter [

	self addAttributeOperator: aParameter equalToken.
	self addAttributeKeyword: aParameter strategy.
	self addAttributeKeyword: aParameter optionalToken.
	self addAttributeKeyword: aParameter paramarrayToken.
	^ self visitProgram: aParameter
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitParameterList: aParameterList [

	self addAttributeOperator: aParameterList leftParenToken.
	self addAttributeOperator: aParameterList rightParenToken.
	^ self visitProgram: aParameterList
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitProcedureCallOrArrayAccess: aProcedureCallOrArrayAccess [

	self addAttributeOperator: aProcedureCallOrArrayAccess leftParenToken.
	self addAttributeOperator:
		aProcedureCallOrArrayAccess rightParenToken.

	^ self visitProgram: aProcedureCallOrArrayAccess
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitQualifiedIdentifier: aQualifiedIdentifier [

self halt.
	
	^ self visitProgram: aQualifiedIdentifier
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitRaiseError: aRaiseError [

	self addAttributeKeyword: aRaiseError eRRORToken.

	^ self visitProgram: aRaiseError
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitRaiseEvent: aRaiseEvent [

	self addAttributeKeyword: aRaiseEvent raiseEventToken.
	^ self visitProgram: aRaiseEvent
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitReDimMultipleVariables: aReDimMultipleVariables [
self halt.
	
	^ self visitProgram: aReDimMultipleVariables
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitReDimVariable: aReDimVariable [

	self addAttributeKeyword: aReDimVariable redimToken.
	self addAttributeKeyword: aReDimVariable preserveToken.

	^ self visitProgram: aReDimVariable
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitResumeEmpty: aResumeEmpty [
	self addAttributeResume: aResumeEmpty resumeToken .
	^ self visitProgram: aResumeEmpty
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitResumeLabel: aResumeLabel [

	self addAttributeResume: aResumeLabel resumeToken.

	^ self visitProgram: aResumeLabel
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitResumeNext: aResumeNext [

	self addAttributeResume: aResumeNext resumeToken.
	self addAttributeNext: aResumeNext nextToken.

	^ self visitProgram: aResumeNext
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitSelect: aSelect [

	aSelect selectTokens do: [ :s | self addAttributeSelect: s ].

	self addAttributeCase: aSelect caseToken.

	self addAttributeEndToken: aSelect endToken.

	^ self visitProgram: aSelect
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitStaticMultipleVariables: aStaticMultipleVariables [
self halt.
	
	^ self visitProgram: aStaticMultipleVariables
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitStaticVariable: aStaticVariable [

	self addAttributeKeyword: aStaticVariable staticToken.

	^ self visitProgram: aStaticVariable
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitStringLiteral: aStringLiteral [

	self addAttributeStringLiteral: aStringLiteral token.

	^ self visitProgram: aStringLiteral
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitSubDefinition: aSubDefinition [

	aSubDefinition subTokens do: [ :s | 
		self addAttributeSub: s ].
	self addAttributeVisibility: aSubDefinition visibility.
	self addAttributeEndToken: aSubDefinition endToken. 

	^ self visitProgram: aSubDefinition
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitTypedThing: aTypedThing [

	self addAttributeAs: aTypedThing aSToken.
	self addAttributeOperator: aTypedThing timesToken.
	^ self visitProgram: aTypedThing
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitUntilTrue: anUntilTrue [

	self addAttributeKeyword: anUntilTrue doToken.
	self addAttributeKeyword: anUntilTrue untilToken.
	self addAttributeKeyword: anUntilTrue loopToken.


	^ self visitProgram: anUntilTrue
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitVariable: aVariable [

	^ self visitProgram: aVariable
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitVariableList: aVariableList [



	^ self visitProgram: aVariableList
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitWhileTrue: aWhileTrue [

	self addAttributeKeyword: aWhileTrue doToken.
	self addAttributeKeyword: aWhileTrue whileToken.
	self addAttributeKeyword: aWhileTrue loopToken.


	^ self visitProgram: aWhileTrue
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitWhileWend: aWhileWend [
	self addAttributeKeyword:	aWhileWend wendToken .
	self addAttributeKeyword: aWhileWend whileToken .
	
	^ self visitProgram: aWhileWend
]

{ #category : #visiting }
MoxingMicrosoftAccessAstComposer >> visitWith: aWith [

	aWith withTokens do: [ :r | self addAttributeWith: r ].
	self addAttributeEndToken: aWith endToken.


	^ self visitProgram: aWith
]
