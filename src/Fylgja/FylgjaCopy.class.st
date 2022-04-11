Class {
	#name : #FylgjaCopy,
	#superclass : #FylgjaProduction,
	#instVars : [
		'cropping',
		'provenanceRelation',
		'fylgja',
		'lookUp'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaCopy >> applyOn: aWriter [

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
				  bindAndReturnEntity: destinationEntity
				  as: provenanceEntityCandidate
				  croppingRelationsWith: cropping
				  usingWriter: contextWriter
				  lookUp: lookUp ]
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

{ #category : #accessing }
FylgjaCopy >> provenanceRelation: aMODeclarationStructuralRelation [ 
	provenanceRelation := aMODeclarationStructuralRelation
]
