Class {
	#name : #FylgjaAddConstructor,
	#superclass : #FylgjaModification,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddConstructor >> applyOn: aMOClassWriter [
	^ aMOClassWriter writeConstructor: [ :constructor |  ]
]
