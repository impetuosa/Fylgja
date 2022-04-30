Class {
	#name : #FylgjaAddLocalVariable,
	#superclass : #FylgjaAddAttribute,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddLocalVariable >> applyOn: aWriter [

	^ aWriter writeVariable: [ :attr | 
		  attr
			  writeOnTop;
			  name: name;
			  typeReference: typeReference;
			  initializer: initializer ]
]
