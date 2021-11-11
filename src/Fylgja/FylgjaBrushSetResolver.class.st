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
	subject accept: self.
	^ brushes 
]

{ #category : #accessing }
FylgjaBrushSetResolver >> subject: aMOJavaClass [

	subject := aMOJavaClass
]

{ #category : #visiting }
FylgjaBrushSetResolver >> visitMOJavaClass: aMOJavaClass [

	brushes
		add: MOAttributeBrush instance;
		add: MOMethodBrush instance;
		add: MOAnnotationBrush instance 
]
