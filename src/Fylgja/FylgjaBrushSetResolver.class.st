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

{ #category : #visiting }
FylgjaBrushSetResolver >> annotate: aLanguage [

	^ MOBrushBuilder brushClass: MOAnnotateBrush language: aLanguage
]

{ #category : #visiting }
FylgjaBrushSetResolver >> annotation: aLanguage [

	^ MOBrushBuilder brushClass: MOAnnotationBrush language: aLanguage
]

{ #category : #visiting }
FylgjaBrushSetResolver >> attribute: aLanguage [

	^ (MOBrushBuilder brushClass: MOVariableBrush language: aLanguage)
		  map: MOAnnotate to: (self annotate: aLanguage);
		  yourself
]

{ #category : #visiting }
FylgjaBrushSetResolver >> class: aLanguage [

	^ (MOBrushBuilder brushClass: MOClassBrush  language: aLanguage)
		  map: MOAnnotate to: (self annotate: aLanguage);
		  map: MOVariable to: (self attribute: aLanguage);
		  map: MOInvocable to: (self method: aLanguage);
		  yourself
]

{ #category : #visiting }
FylgjaBrushSetResolver >> enum: aLanguage [

	^ (MOBrushBuilder brushClass: MOEnumBrush language: aLanguage)
		  map: MOAnnotate to: (self annotate: aLanguage);
		  map: MOVariable to: (self attribute: aLanguage);
		  map: MOInvocable to: (self method: aLanguage);
		  yourself
]

{ #category : #visiting }
FylgjaBrushSetResolver >> interface: aLanguage [

	^ (MOBrushBuilder brushClass: MOInterfaceBrush language: aLanguage)
		  map: MOAnnotate to: (self annotate: aLanguage);
		  map: MOVariable to: (self attribute: aLanguage);
		  map: MOInvocable to: (self method: aLanguage);
		  yourself
]

{ #category : #visiting }
FylgjaBrushSetResolver >> method: aLanguage [

	^ (MOBrushBuilder brushClass: MOMethodBrush language: aLanguage)
		  map: MOAnnotate to: (self annotate: aLanguage);
		  map: MOVariable to: (self variable: aLanguage);
		  yourself
]

{ #category : #visiting }
FylgjaBrushSetResolver >> register: aBrushBuilder [

	brushes add: aBrushBuilder
]

{ #category : #visiting }
FylgjaBrushSetResolver >> registerDefaultClassBrushes: aMOClass [

	self register: (self attribute: aMOClass language).
	self register: (self method: aMOClass language)
]

{ #category : #navigating }
FylgjaBrushSetResolver >> resolve [

	brushes := Set new.
	subject acceptLanguageVisitor: self.
	^ brushes
]

{ #category : #accessing }
FylgjaBrushSetResolver >> subject: aMOJavaClass [

	subject := aMOJavaClass
]

{ #category : #visiting }
FylgjaBrushSetResolver >> variable: aLanguage [

	^ MOBrushBuilder brushClass: MOVariableBrush language: aLanguage
]

{ #category : #visiting }
FylgjaBrushSetResolver >> visitJavaClass: aMOClass [

	self registerDefaultClassBrushes: aMOClass. 
	self register: (self annotate: aMOClass language)
]

{ #category : #visiting }
FylgjaBrushSetResolver >> visitJavaPackage: aMOPackage [
	self register: (self enum: aMOPackage language).
	self register: (self class: aMOPackage language).
	self register: (self annotation: aMOPackage language).
	self register: (self interface: aMOPackage language)
]

{ #category : #visiting }
FylgjaBrushSetResolver >> visitTypescriptClass: aMOClass [

	self registerDefaultClassBrushes: aMOClass
]
