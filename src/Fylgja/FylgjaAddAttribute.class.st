Class {
	#name : #FylgjaAddAttribute,
	#superclass : #FylgjaProduction,
	#instVars : [
		'name',
		'typeReference',
		'visibility',
		'initializer'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddAttribute >> applyOn: aWriter [

	^ aWriter writeAttribute: [ :attr | 
		  attr
			  name: name;
			  typeReference: typeReference;
			  visibility: self visibility;
			  initializer: initializer ]
]

{ #category : #accessing }
FylgjaAddAttribute >> initializer: anInitializer [

	initializer := anInitializer
]

{ #category : #accessing }
FylgjaAddAttribute >> name: aString [ 
	name := aString .
]

{ #category : #accessing }
FylgjaAddAttribute >> typeReference: aMOTypeReference [

	typeReference := aMOTypeReference
]

{ #category : #'instance creation' }
FylgjaAddAttribute >> visibility [

	^ visibility ifNil: [ #public ]
]

{ #category : #accessing }
FylgjaAddAttribute >> visibility: aString [

	visibility := aString
]
