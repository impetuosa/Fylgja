"
#Modification operations

These operations are of the transofrmation kind. All of them inherit from the FylgjaModification class.
The transformations proposed in this hierarchy are of the kind of producing specific bricks of code such as: AddAttribute, AddGetter / AddSetter etc. 
"
Class {
	#name : #FylgjaModification,
	#superclass : #FylgjaOperation,
	#category : #'Fylgja-Rule-Transformations'
}

{ #category : #'as yet unclassified' }
FylgjaModification class >> holdsPackageDocumentation [

	^ self = FylgjaModification
]

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
	ref referee: declaration.
	^ ref
]
