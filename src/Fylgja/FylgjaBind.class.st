Class {
	#name : #FylgjaBind,
	#superclass : #FylgjaModification,
	#instVars : [
		'cropping',
		'destinationEntity',
		'fylgja',
		'lookUp',
		'provenanceEntityCandidate'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaBind >> canBeAppliedTo: aWriter [ 
	 self halt .
]

{ #category : #'instance creation' }
FylgjaBind >> privateApplyOn: aWriter [

	^ fylgja
		  mapEntity: destinationEntity
		  as: provenanceEntityCandidate
		  croppingRelationsWith: cropping
		  usingWriter: aWriter
		  lookUp: lookUp
]
