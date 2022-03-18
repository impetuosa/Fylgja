Class {
	#name : #FylgjaBindToSameStub,
	#superclass : #FylgjaBinding,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #testing }
FylgjaBindToSameStub >> bind: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	| candidate |
	self assert:
		(aCandidateRelation read: aDestinationEntity) isFylgjaStub.


	^ aDestinationEntity
]
