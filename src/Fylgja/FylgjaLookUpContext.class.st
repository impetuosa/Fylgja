Class {
	#name : #FylgjaLookUpContext,
	#superclass : #Object,
	#instVars : [
		'destination',
		'mrs'
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
FylgjaLookUpContext >> lookupRulesForDelegating: aProvenanceEntity [

	^ self ensureNotDuplicated: (mrs
			   lookupRulesForDelegating: aProvenanceEntity
			   toContext: destination)
]

{ #category : #'as yet unclassified' }
FylgjaLookUpContext >> lookupRulesForMapping: aProvenanceEntity [

	^ self ensureNotDuplicated:
		  (mrs
			   lookupRulesForMapping: aProvenanceEntity
			   toContext: destination)
]

{ #category : #'as yet unclassified' }
FylgjaLookUpContext >> lookupRulesForProducing: aProvenanceEntity [

	^ self ensureNotDuplicated:
		  (mrs
			   lookupRulesForProducing: aProvenanceEntity
			   toContext: destination)
]

{ #category : #'as yet unclassified' }
FylgjaLookUpContext >> mrs: aMrs destination: aDestinationContext [ 
	mrs := aMrs .
	destination := aDestinationContext
]
