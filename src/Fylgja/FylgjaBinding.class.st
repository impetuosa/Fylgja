Class {
	#name : #FylgjaBinding,
	#superclass : #FylgjaOperation,
	#category : #'Fylgja-Rule-BindingOperations'
}

{ #category : #testing }
FylgjaBinding >> bind: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [
	self subclassResponsibility 
]

{ #category : #testing }
FylgjaBinding >> isAdapting [

	^ true
]
