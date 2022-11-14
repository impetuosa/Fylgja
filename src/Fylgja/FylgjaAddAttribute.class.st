Class {
	#name : #FylgjaAddAttribute,
	#superclass : #FylgjaModification,
	#instVars : [
		'name',
		'typeReference',
		'visibility',
		'initializer'
	],
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #'instance creation' }
FylgjaAddAttribute class >> possibleWritingMessages [

	^ { #writeAttribute: }
]

{ #category : #accessing }
FylgjaAddAttribute >> initializer: anInitializer [

	initializer := anInitializer
]

{ #category : #accessing }
FylgjaAddAttribute >> name: aString [ 
	name := aString .
]

{ #category : #'instance creation' }
FylgjaAddAttribute >> privateApplyOn: aWriter [

	^ aWriter writeAttribute: [ :attr | 
		  attr
			  name: name;
			  typeReference: typeReference;
			  visibility: self visibility;
			  initializer: initializer ]
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
