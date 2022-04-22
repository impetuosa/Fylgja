Class {
	#name : #FylgjaModification,
	#superclass : #FylgjaOperation,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaModification >> applyOn: aWriter [
	self subclassResponsibility 
]

{ #category : #'instance creation' }
FylgjaModification >> typeReferenceBasedOn: aBlock using: aWriter [

	| declaration ref |
	declaration := ((aWriter model allEntitiesSelect: [ :a | 
		                 aBlock value: a ]) ifEmpty: [ 
		                aWriter model catalogEntitiesSelect: [ :a | 
			                aBlock value: a ] ]) first.
	ref := declaration isParametrizable
		       ifTrue: [ 
			       aWriter
				       parametrizedTypeReferenceNamed: declaration name
				       arguments: {  } ]
		       ifFalse: [ aWriter typeReferenceNamed: declaration name ].
	ref candidate: declaration.
	^ ref
]
