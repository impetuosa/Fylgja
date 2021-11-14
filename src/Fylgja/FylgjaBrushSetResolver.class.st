Class {
	#name : #FylgjaBrushSetResolver,
	#superclass : #Object,
	#instVars : [
		'subject',
		'brushes'
	],
	#category : #'Fylgja-Test'
}

{ #category : #'instance creation' }
FylgjaBrushSetResolver class >> newFor: aMOJavaClass [

	^ self new
		  subject: aMOJavaClass;
		  yourself
]

{ #category : #navigating }
FylgjaBrushSetResolver >> resolve [
	brushes := Set new.
	subject acceptVisitor: self.
	^ brushes 
]

{ #category : #accessing }
FylgjaBrushSetResolver >> subject: aMOJavaClass [

	subject := aMOJavaClass
]

{ #category : #visiting }
FylgjaBrushSetResolver >> visitClass: aMOJavaClass [

	brushes
		add: MOAttributeBrush instance;
		add: MOMethodBrush instance;
		add: MOAnnotateBrush instance 
]

{ #category : #visiting }
FylgjaBrushSetResolver >> visitPackage: aMOPackage [

	brushes
		add: MOEnumBrush instance;
		add: MOStructBrush instance;
		add: MOClassBrush instance;
		add: MOModuleBrush instance;
		add: MOAnnotationBrush instance;
		add: MOInterfaceBrush instance
]
