Class {
	#name : #FylgjaCondition,
	#superclass : #Object,
	#instVars : [
		'priority'
	],
	#category : #'Fylgja-Rule-Conditions'
}

{ #category : #accessing }
FylgjaCondition class >> priority [

	^ 0
]

{ #category : #'as yet unclassified' }
FylgjaCondition >> increasePriority [

	priority := priority + 1
]

{ #category : #testing }
FylgjaCondition >> initialize [

	super initialize.
	priority := self class priority
]

{ #category : #testing }
FylgjaCondition >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [
  self subclassResponsibility
]

{ #category : #testing }
FylgjaCondition >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation [

	^ self subclassResponsibility
]

{ #category : #accessing }
FylgjaCondition >> priority [
	^ priority
]
