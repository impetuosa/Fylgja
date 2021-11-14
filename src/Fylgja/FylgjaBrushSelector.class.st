Class {
	#name : #FylgjaBrushSelector,
	#superclass : #Object,
	#instVars : [
		'subject',
		'brushes'
	],
	#category : #'Fylgja-Test'
}

{ #category : #'instance creation' }
FylgjaBrushSelector class >> newFor: anAlcixFunction [ 


	^ self new
		  subject: anAlcixFunction;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaBrushSelector >> chooseBetween: aCollection [ 
	brushes := aCollection. 
	subject accept: self.
	^ brushes
]

{ #category : #accessing }
FylgjaBrushSelector >> subject: anAlcixFunction [ 
	subject := anAlcixFunction
]

{ #category : #visiting }
FylgjaBrushSelector >> visitClass: anAlcixClass [

	brushes := brushes select: [ :a | a writesClass ]
]

{ #category : #visiting }
FylgjaBrushSelector >> visitFunction: anAlcixFunction [

	brushes := brushes select: [ :a | a writesInvocableBehaviour ]
]
