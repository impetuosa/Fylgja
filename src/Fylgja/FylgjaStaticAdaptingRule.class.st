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
FylgjaStaticAdaptingRule >> mapArguments: aReference using: aMapping [

	^ aMapping mapsArguments
		  ifFalse: [ {  } ]
		  ifTrue: [ aMapping map: aReference arguments ]
]

{ #category : #'as yet unclassified' }
FylgjaStaticAdaptingRule >> mapReceiver: aReference using: aFylgjaNestedMapping [

	^ aFylgjaNestedMapping mapReceiver: aReference arguments
]

{ #category : #testing }
FylgjaStaticAdaptingRule >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [
	 self subclassResponsibility 
]
