Class {
	#name : #FylgjaCopy,
	#superclass : #FylgjaModification,
	#instVars : [
		'cropping',
		'provenanceRelation',
		'fylgja',
		'lookUp'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaCopy >> canBeAppliedTo: aWriter [

	^ true
]

{ #category : #accessing }
FylgjaCopy >> cropping: aFullBlockClosure [ 
	cropping := aFullBlockClosure
]

{ #category : #accessing }
FylgjaCopy >> fylgja: aFylgjaDerivativeModel [ 
	fylgja := aFylgjaDerivativeModel
]

{ #category : #accessing }
FylgjaCopy >> lookUp: aFylgjaLookUpContext [ 
	lookUp := aFylgjaLookUpContext
]

{ #category : #'instance creation' }
FylgjaCopy >> privateApplyOn: aWriter [

	^ aWriter
		  writeCopyOf: provenanceRelation
		  croppingRelationsWith: cropping
		  readingValues: [ :context :value | 
			  fylgja
				  migrate: value
				  croppingRelationsWith: cropping
				  intoDestinationWriter: context
				  lookUp: lookUp ]
		  bindingWithCandidates: [ 
			  :contextWriter 
			  :provenanceEntityCandidate 
			  :destinationEntity | 
			  fylgja
				  mapEntity: destinationEntity
				  as: provenanceEntityCandidate
				  croppingRelationsWith: cropping
				  usingWriter: contextWriter
				  lookUp: lookUp ]
]

{ #category : #accessing }
FylgjaCopy >> provenanceRelation: aMODeclarationStructuralRelation [ 
	provenanceRelation := aMODeclarationStructuralRelation
]
