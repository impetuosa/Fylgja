Class {
	#name : #FylgjaLookUpContext,
	#superclass : #Object,
	#instVars : [
		'mrs',
		'destinationContextRelation'
	],
	#category : #'Fylgja-MRS'
}

{ #category : #'as yet unclassified' }
FylgjaLookUpContext >> ensureNotDuplicated: rules [

	[ 
	rules asDictionary values.
	^ rules collect: #value ]
		on: Error
		do: [ 
			self error:
				'Rule selection collision: More than one rule applies on the same map space for the given entity! ' ]
]

{ #category : #'as yet unclassified' }
FylgjaLookUpContext >> lookupRulesForBinding: aDestinationEntity with: aCandidateRelation [

	^ self ensureNotDuplicated: (mrs
			   lookupRulesForBinding: aDestinationEntity
			   with: aCandidateRelation
			   inTheContextOf: destinationContextRelation)
]

{ #category : #'as yet unclassified' }
FylgjaLookUpContext >> lookupRulesForDelegating: aProvenanceEntityRelation [

	^ self ensureNotDuplicated: (mrs
			   lookupRulesForDelegating: aProvenanceEntityRelation
			   toContext: destinationContextRelation)
]

{ #category : #'as yet unclassified' }
FylgjaLookUpContext >> lookupRulesForProducing: aProvenanceEntityRelation [

	^ self ensureNotDuplicated:
		  (mrs
			   lookupRulesForProducing: aProvenanceEntityRelation
			   toContext: destinationContextRelation)
]

{ #category : #'as yet unclassified' }
FylgjaLookUpContext >> lookupRulesForProducing: aProvenanceEntityRelation forWriting: aType [

	^ self ensureNotDuplicated: (mrs
			   lookupRulesForProducing: aProvenanceEntityRelation
			   toContext: destinationContextRelation
			   forWriting: aType)
]

{ #category : #'as yet unclassified' }
FylgjaLookUpContext >> mrs: aMrs destination: aDestinationContextRelation [ 
	mrs := aMrs .
	destinationContextRelation := aDestinationContextRelation
]
