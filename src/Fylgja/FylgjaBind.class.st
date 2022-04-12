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
FylgjaBind >> applyOn: aWriter [

	^ fylgja
		  bindAndReturnEntity: destinationEntity
		  as: provenanceEntityCandidate
		  croppingRelationsWith: cropping
		  usingWriter: aWriter
		  lookUp: lookUp
]
