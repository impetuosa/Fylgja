Class {
	#name : #FylgjaMigrate,
	#superclass : #FylgjaModification,
	#instVars : [
		'cropping',
		'provenanceRelation',
		'fylgja',
		'lookUp'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaMigrate >> canBeAppliedTo: aWriter [

	^ true
]

{ #category : #accessing }
FylgjaMigrate >> cropping: aFullBlockClosure [ 
	cropping := aFullBlockClosure
]

{ #category : #accessing }
FylgjaMigrate >> fylgja: aFylgjaDerivativeModel [ 
	fylgja := aFylgjaDerivativeModel
]

{ #category : #accessing }
FylgjaMigrate >> lookUp: aFylgjaLookUpContext [ 
	lookUp := aFylgjaLookUpContext
]

{ #category : #'instance creation' }
FylgjaMigrate >> privateApplyOn: aWriter [

	^ fylgja
		  migrate: provenanceRelation
		  croppingRelationsWith: cropping
		  intoDestinationWriter: aWriter
		  lookUp: lookUp
]

{ #category : #'as yet unclassified' }
FylgjaMigrate >> provenanceEntity: aProvenanceEntity [

	self provenanceRelation:
		(fylgja readEntitysContextualizingRelation: aProvenanceEntity)
]

{ #category : #accessing }
FylgjaMigrate >> provenanceRelation: aMONullDeclarationRelation [ 
	provenanceRelation := aMONullDeclarationRelation
]
