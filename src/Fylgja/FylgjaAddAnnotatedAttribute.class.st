Class {
	#name : #FylgjaAddAnnotatedAttribute,
	#superclass : #FylgjaAddAttribute,
	#instVars : [
		'annotationProductions'
	],
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #adding }
FylgjaAddAnnotatedAttribute >> addAnnotationProduction: aFylgjaAnnotate [

	annotationProductions add: aFylgjaAnnotate
]

{ #category : #adding }
FylgjaAddAnnotatedAttribute >> initialize [

	super initialize.
	annotationProductions := OrderedCollection new
]

{ #category : #'instance creation' }
FylgjaAddAnnotatedAttribute >> privateApplyOn: aWriter [

	^ aWriter writeAttribute: [ :attr | 
		  annotationProductions do: [ :a | a privateApplyOn: attr ].
		  attr
			  name: name;
			  typeReference: typeReference;
			  visibility: self visibility;
			  initializer: initializer ]
]
