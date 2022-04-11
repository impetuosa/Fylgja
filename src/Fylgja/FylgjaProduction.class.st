Class {
	#name : #FylgjaProduction,
	#superclass : #FylgjaOperation,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaProduction >> applyOn: aWriter [
	self subclassResponsibility 
]

{ #category : #'instance creation' }
FylgjaProduction >> typeReferenceBasedOn: aBlock using: aWriter [

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
