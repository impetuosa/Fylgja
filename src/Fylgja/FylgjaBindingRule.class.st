Class {
	#name : #FylgjaBindingRule,
	#superclass : #FylgjaRule,
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaBindingRule >> bind: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock destinationWriter: aWriter lookUp: aLookupContext using: aModifiedFylgjaMigrationEngine [

	^ operation
		  bind: aDestinationEntity
		  as: aCandidateRelation
		  croppingRelationsWith: aBlock
		  destinationWriter: aWriter
		  lookUp: aLookupContext
		  using: aModifiedFylgjaMigrationEngine
]

{ #category : #testing }
FylgjaBindingRule >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation [

	^ condition
		  matches: aDestinationEntity
		  context: aDestinationContextRelation
		  toBindAs: aCandidateRelation
]

{ #category : #'as yet unclassified' }
FylgjaBindingRule >> printingSymbol [ 
	^ '=>'
]
