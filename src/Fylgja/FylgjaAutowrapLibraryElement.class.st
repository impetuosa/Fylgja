Class {
	#name : #FylgjaAutowrapLibraryElement,
	#superclass : #FylgjaStaticAdaptingRule,
	#instVars : [
		'mappings'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaAutowrapLibraryElement >> bind: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	| parentUnit compatibilityType package |
	parentUnit := aCandidateRelation to.
	" 
		This rule may steal the possiblity of this reference to have a stub. 
		And this rule will not fix directly that problem, but indirectly by migrating the missing part. 
	"
	aDestinationEntity candidate ifNil: [ 
		aFylgja
			installStub: aDestinationEntity
			as: aCandidateRelation
			croppingRelationsWith: aBlock
			usingWriter: aDestinationWriter
			lookUp: aFylgjaLookUpContext ].

	[ parentUnit isType or: [ parentUnit isModule ] ] whileFalse: [ 
		parentUnit := parentUnit parent ].

	package := aDestinationWriter model packages detect: [ :p | 
		           p name includesSubstring: #paper caseSensitive: false ].

	compatibilityType := package allTypes
		                     detect: [ :t | t name = parentUnit name ]
		                     ifNone: [ nil ].
	compatibilityType
		ifNil: [ 
			aFylgja
				produce: parentUnit
				croppingRelationsWith: [ :col | 
					self
						rejectAnyContainment: col
						from: parentUnit
						thatIsNot: aCandidateRelation to ]
				into: package ]
		ifNotNil: [ 
			(compatibilityType allContainments anySatisfy: [ :a | 
				 a name = aCandidateRelation to name ]) ifFalse: [ 
				aFylgja
					produce: aCandidateRelation to
					croppingRelationsWith: [ :a | a ]
					into: compatibilityType ] ].


	^ aDestinationEntity
]

{ #category : #testing }
FylgjaAutowrapLibraryElement >> isTypeOrInsideType: aCandidate [

	| parentUnit |
	parentUnit := aCandidate.

	[ parentUnit isType or: [ parentUnit isModule ] ] whileFalse: [ 
		parentUnit := parentUnit parent.
		(parentUnit isKindOf: MOModel) ifTrue: [ ^ false ] ].
	^ true
]

{ #category : #testing }
FylgjaAutowrapLibraryElement >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [

	mappings := aLookup resolveAllMappingsRelatedTo:
		            aCandidateRelation to.
	
	mappings ifNotEmpty: [ ^ false ].
	mappings := aLookup.
	^ aCandidateRelation to isDefinedInLibrary and: [ 
		  aCandidateRelation to isPrimitiveType not and: [ 
			  self isTypeOrInsideType: aCandidateRelation to ] ]
]

{ #category : #'as yet unclassified' }
FylgjaAutowrapLibraryElement >> rejectAnyContainment: aCollection from: aMOModule thatIsNot: aMOGlobalVariable [

	| thisModule |
	thisModule := aCollection select: [ :a | 
		              a from isSameEntity: aMOModule ].
	thisModule := thisModule reject: [ :a | 
		              a isContainment and: [ 
			              (a to isSameEntity: aMOGlobalVariable) not ] ].
	^ thisModule
	  , (aCollection reject: [ :a | a from isSameEntity: aMOModule ])
]
