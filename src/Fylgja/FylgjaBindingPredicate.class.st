Class {
	#name : #FylgjaBindingPredicate,
	#superclass : #FylgjaOperation,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #testing }
FylgjaBindingPredicate >> bind: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [
	self subclassResponsibility 
]

{ #category : #testing }
FylgjaBindingPredicate >> isBinding [

	^ true
]
