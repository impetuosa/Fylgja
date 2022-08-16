Class {
	#name : #FylgjaModification,
	#superclass : #FylgjaOperation,
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #'instance creation' }
FylgjaModification >> applyOn: aWriter [

	self
		assert: (self canBeAppliedTo: aWriter)
		description:
		'Impossible to apply this transformation to the given writer '.
	^ self privateApplyOn: aWriter
]

{ #category : #'instance creation' }
FylgjaModification >> canBeAppliedTo: aWriter [

	^ self canWriteOver: aWriter
]

{ #category : #'instance creation' }
FylgjaModification >> privateApplyOn: aWriter [

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
