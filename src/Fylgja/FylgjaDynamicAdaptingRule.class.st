Class {
	#name : #FylgjaDynamicAdaptingRule,
	#superclass : #FylgjaDynamicRule,
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaDynamicAdaptingRule >> bind: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock destinationWriter: aWriter lookUp: aLookupContext using: aModifiedFylgjaMigrationEngine [

	^ operation
		  bind: aDestinationEntity
		  as: aCandidateRelation
		  croppingRelationsWith: aBlock
		  destinationWriter: aWriter
		  lookUp: aLookupContext
		  using: aModifiedFylgjaMigrationEngine
]

{ #category : #testing }
FylgjaDynamicAdaptingRule >> isAdaptingRule [

	^ true
]

{ #category : #testing }
FylgjaDynamicAdaptingRule >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [

	^ condition
		  matches: aDestinationEntity
		  context: aDestinationContextRelation
		  toBindAs: aCandidateRelation
		  consideringMappingsFrom: aLookup
]

{ #category : #'as yet unclassified' }
FylgjaDynamicAdaptingRule >> printingSymbol [ 
	^ '=>'
]
