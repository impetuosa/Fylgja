Class {
	#name : #MoxingTypescriptAstComposer,
	#superclass : #MoxingTextComposer,
	#traits : 'TJSProgramNodeVisitor',
	#classTraits : 'TJSProgramNodeVisitor classTrait',
	#category : #'Fylgja-UI-Text'
}

{ #category : #generated }
MoxingTypescriptAstComposer >> visitClassExpression: aClassExpression [
	self addAttributeClass: aClassExpression classToken. 
	self addAttributeExtends: aClassExpression extendsToken. 
	self addAttributeImplements: aClassExpression implementsToken . 
	^ self visitExpression: aClassExpression
]

{ #category : #generated }
MoxingTypescriptAstComposer >> visitImportDeclaration: anImportDeclaration [

	self addAttributeImport: anImportDeclaration importToken.
	self addAttributeImport: anImportDeclaration fromToken.
	^ self visitProgram: anImportDeclaration
]
