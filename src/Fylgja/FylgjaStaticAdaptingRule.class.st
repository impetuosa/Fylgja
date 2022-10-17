Class {
	#name : #FylgjaStaticAdaptingRule,
	#superclass : #FylgjaStaticRule,
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaStaticAdaptingRule >> bind: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock destinationWriter: aWriter lookUp: aLookupContext using: aModifiedFylgjaMigrationEngine [
	 self subclassResponsibility 
]

{ #category : #testing }
FylgjaStaticAdaptingRule >> isAdaptingRule [

	^ true
]

{ #category : #testing }
FylgjaStaticAdaptingRule >> mapArguments: aSetOfArguments using: aMapping [

	^ aMapping map: aSetOfArguments
]

{ #category : #'as yet unclassified' }
FylgjaStaticAdaptingRule >> mapReceiver: aCollection using: aFylgjaNestedMapping [

	^ aFylgjaNestedMapping mapReceiver: aCollection
]

{ #category : #testing }
FylgjaStaticAdaptingRule >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [
	 self subclassResponsibility 
]
