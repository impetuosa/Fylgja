Class {
	#name : #FylgjaAddAnnotatedAttribute,
	#superclass : #FylgjaAddAttribute,
	#instVars : [
		'annotationProductions'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #adding }
FylgjaAddAnnotatedAttribute >> addAnnotationProduction: aFylgjaAnnotate [

	annotationProductions add: aFylgjaAnnotate
]

{ #category : #'instance creation' }
FylgjaAddAnnotatedAttribute >> applyOn: aWriter [

	^ aWriter writeAttribute: [ :attr | 
		  annotationProductions do: [ :a | a applyOn: attr ].
		  attr
			  name: name;
			  typeReference: typeReference;
			  visibility: self visibility;
			  initializer: initializer ]
]

{ #category : #adding }
FylgjaAddAnnotatedAttribute >> initialize [

	super initialize.
	annotationProductions := OrderedCollection new
]
