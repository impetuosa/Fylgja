Class {
	#name : #MoxingJavaAstComposer,
	#superclass : #MoxingTextComposer,
	#traits : 'TJavaProgramNodeVisitor',
	#classTraits : 'TJavaProgramNodeVisitor classTrait',
	#category : #'Fylgja-UI-Text'
}

{ #category : #generated }
MoxingJavaAstComposer >> visitAnnotation: anAnnotation [

	self addAttributeAnnotation: anAnnotation _at.
	self addAttributeAnnotation: anAnnotation name.
	^ self visitProgram: anAnnotation
]

{ #category : #generated }
MoxingJavaAstComposer >> visitArrayType: anArrayType [

	^ self visitProgram: anArrayType
]

{ #category : #generated }
MoxingJavaAstComposer >> visitClassDeclaration: aClassDeclaration [
	aClassDeclaration modifiers do: [ : a | self addAttributeModifier: a  ].
	self addAttributeClass: aClassDeclaration classToken.
	self addAttributeExtends: aClassDeclaration extendsToken.
	self addAttributeImplements: aClassDeclaration implementsToken.
	^ self visitDeclaration: aClassDeclaration
]

{ #category : #generated }
MoxingJavaAstComposer >> visitConstructorDeclaration: aConstructorDeclaration [

	aConstructorDeclaration modifiers do: [ :a | 
		self addAttributeModifier: a ].
	^ self visitDeclaration: aConstructorDeclaration
]

{ #category : #generated }
MoxingJavaAstComposer >> visitFieldDeclaration: aFieldDeclaration [
aFieldDeclaration modifiers do: [ :a | self addAttributeModifier: a ].
	^ self visitDeclaration: aFieldDeclaration
]

{ #category : #generated }
MoxingJavaAstComposer >> visitInterfaceDeclaration: anInterfaceDeclaration [

	anInterfaceDeclaration modifiers do: [ :a | 
		self addAttributeModifier: a ].
	self addAttributeClass: anInterfaceDeclaration interfaceToken.
	self addAttributeImplements: anInterfaceDeclaration extendsToken.
	^ self visitDeclaration: anInterfaceDeclaration
]

{ #category : #generated }
MoxingJavaAstComposer >> visitLiteral: aLiteral [

	self addAttributeStringLiteral: aLiteral token.
	^ self visitProgram: aLiteral
]

{ #category : #generated }
MoxingJavaAstComposer >> visitMethodDeclaration: aMethodDeclaration [

	aMethodDeclaration modifiers do: [ :a | self addAttributeModifier: a ].
	^ self visitDeclaration: aMethodDeclaration
]

{ #category : #generated }
MoxingJavaAstComposer >> visitNew: aNew [

	self addAttributeNew: aNew newToken.
	^ self visitExpression: aNew
]

{ #category : #generated }
MoxingJavaAstComposer >> visitPackageDeclaration: aPackageDeclaration [

	self addAttributePackage: aPackageDeclaration packageToken.
	^ self visitDeclaration: aPackageDeclaration
]

{ #category : #generated }
MoxingJavaAstComposer >> visitPrimitiveType: aPrimitiveType [

	self addAttributeType: aPrimitiveType token.
	^ self visitProgram: aPrimitiveType
]

{ #category : #generated }
MoxingJavaAstComposer >> visitReturnStatement: aReturnStatement [

	self addAttributeReturn: aReturnStatement returnToken.
	^ self visitStatement: aReturnStatement
]

{ #category : #generated }
MoxingJavaAstComposer >> visitSingleTypeImportDeclaration: aSingleTypeImportDeclaration [

	self addAttributeImport: aSingleTypeImportDeclaration importToken.
	^ self visitDeclaration: aSingleTypeImportDeclaration
]

{ #category : #generated }
MoxingJavaAstComposer >> visitType: aType [
	
	self addAttributeType: aType name .
	^ self visitProgram: aType
]
