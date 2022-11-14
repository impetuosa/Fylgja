Class {
	#name : #FylgjaAddLocalVariable,
	#superclass : #FylgjaAddAttribute,
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #'instance creation' }
FylgjaAddLocalVariable class >> possibleWritingMessages [

	^ { #writeVariable: }
]

{ #category : #'instance creation' }
FylgjaAddLocalVariable >> privateApplyOn: aWriter [

	^ aWriter writeVariable: [ :attr | 
		  attr
			  writeOnTop;
			  name: name;
			  typeReference: typeReference;
			  initializer: initializer ]
]
