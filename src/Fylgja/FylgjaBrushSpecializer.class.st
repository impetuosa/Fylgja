Class {
	#name : #FylgjaBrushSpecializer,
	#superclass : #Object,
	#instVars : [
		'subject',
		'builder'
	],
	#category : #'Fylgja-Test'
}

{ #category : #'instance creation' }
FylgjaBrushSpecializer class >> newFor: aMOJavaClass [

	^ self new
		  subject: aMOJavaClass;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaBrushSpecializer >> specialize: aMOBrushBuilder [

	builder := aMOBrushBuilder.
	subject acceptLanguageVisitor: self.
	^ builder buildWith: self
]

{ #category : #accessing }
FylgjaBrushSpecializer >> subject [
	^ subject
]

{ #category : #accessing }
FylgjaBrushSpecializer >> subject: anAlcixFunction [ 
	subject := anAlcixFunction
]

{ #category : #visiting }
FylgjaBrushSpecializer >> visitMicrosoftAccessClass: anAlcixClass [ 
	" nothing to do "
]

{ #category : #visiting }
FylgjaBrushSpecializer >> visitMicrosoftAccessFunction: anAlcixFunction [

	^ builder
		  mapping: MOErrorPolicy
		  to: MOErrorTryCatchPolicy
		  with: MOOnErrorGoToToTryCatchTransform;
		  mapping: MOReturnPolicy
		  to: MOReturnExpressionPolicy
		  with: MOAssignReturnToReturnExpressionTransform
]
