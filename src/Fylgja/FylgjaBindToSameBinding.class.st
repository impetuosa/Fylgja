Class {
	#name : #FylgjaBindToSameBinding,
	#superclass : #FylgjaBinding,
	#category : #'Fylgja-Rule-Binding'
}

{ #category : #testing }
FylgjaBindToSameBinding >> bind: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	^ aDestinationEntity
]
