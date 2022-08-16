Class {
	#name : #FylgjaLookUpContext,
	#superclass : #Object,
	#instVars : [
		'mrs',
		'destinationContextRelation'
	],
	#category : #'Fylgja-MRS'
}

{ #category : #query }
FylgjaLookUpContext >> allPossibleBindingRules [

	^ mrs allPossibleBindingRules
]

{ #category : #query }
FylgjaLookUpContext >> allPossibleDelegatingRules [

	^ mrs allPossibleDelegatingRules
]

{ #category : #query }
FylgjaLookUpContext >> allPossibleProducingRules [
	^ mrs allPossibleProducingRules
]

{ #category : #convenience }
FylgjaLookUpContext >> ensureNotDuplicated: rules [

	^ mrs chooseRule: rules
]

{ #category : #query }
FylgjaLookUpContext >> lookupAllRulesForProducing: aMODeclarationStructuralRelation with: aWriter [

	^ mrs
		  lookupRulesForProducing: aMODeclarationStructuralRelation
		  toContext: destinationContextRelation
		  with: aWriter
]

{ #category : #'single response query' }
FylgjaLookUpContext >> lookupRulesForBinding: aDestinationEntity with: aCandidateRelation using: aWriter [

	^ self ensureNotDuplicated: (mrs
			   lookupRulesForBinding: aDestinationEntity
			   with: aCandidateRelation
			   inTheContextOf: destinationContextRelation)
]

{ #category : #'single response query' }
FylgjaLookUpContext >> lookupRulesForDelegating: aProvenanceEntityRelation with: aWriter [

	^ self ensureNotDuplicated: (mrs
			   lookupRulesForDelegating: aProvenanceEntityRelation
			   toContext: destinationContextRelation
			   with: aWriter)
]

{ #category : #'single response query' }
FylgjaLookUpContext >> lookupRulesForProducing: aProvenanceEntityRelation forWriting: aType with: aWriter [

	^ self ensureNotDuplicated: (mrs
			   lookupRulesForProducing: aProvenanceEntityRelation
			   toContext: destinationContextRelation
			   forWriting: aType
			   with: aWriter)
]

{ #category : #accessing }
FylgjaLookUpContext >> mrs: aMrs destination: aDestinationContextRelation [ 
	mrs := aMrs .
	destinationContextRelation := aDestinationContextRelation
]
