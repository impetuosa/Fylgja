Class {
	#name : #FylgjaAddAttribute,
	#superclass : #FylgjaProduce,
	#instVars : [
		'name',
		'typeReference',
		'visibility'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddAttribute >> applyOn: aWriter [

	^ aWriter writeAttribute: [ :attr | 
		  attr
			  name: name;
			  typeReference: typeReference;
			  visibility: self visibility ]
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
