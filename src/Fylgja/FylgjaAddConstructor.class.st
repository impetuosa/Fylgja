Class {
	#name : #FylgjaAddConstructor,
	#superclass : #FylgjaModification,
	#category : #'Fylgja-Rule-Transformations'
}

{ #category : #'instance creation' }
FylgjaAddConstructor class >> possibleWritingMessages [

	^ { #writeConstructor: }
]

{ #category : #'instance creation' }
FylgjaAddConstructor >> privateApplyOn: aMOClassWriter [
	^ aMOClassWriter writeConstructor: [ :constructor |  ]
]
