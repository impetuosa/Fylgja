Class {
	#name : #FylgjaNorthwindRuleInstaller,
	#superclass : #Object,
	#instVars : [
		'fylgja',
		'northwind'
	],
	#category : #'Fylgja-Rule-Installer-Northwind'
}

{ #category : #'as yet unclassified' }
FylgjaNorthwindRuleInstaller >> accessDbAttachment [

	^ northwind entities
		  detect: [ :a | 
		  (a isKindOf: MOPrimitiveType) and: [ a name = #dbAttachment ] ]
		  ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
FylgjaNorthwindRuleInstaller >> accessDbLongType [

	^ northwind entities
		  detect: [ :a | 
		  (a isKindOf: MOPrimitiveType) and: [ a name = #dbLong ] ]
		  ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
FylgjaNorthwindRuleInstaller >> accessDbMemoType [

	^ northwind entities
		  detect: [ :a | 
		  (a isKindOf: MOPrimitiveType) and: [ a name = #dbMemo ] ]
		  ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
FylgjaNorthwindRuleInstaller >> accessDbTextType [

	^ northwind entities detect: [ :a | 
		  (a isKindOf: MOPrimitiveType) and: [ a name = #dbText ] ]
]

{ #category : #general }
FylgjaNorthwindRuleInstaller >> angular: aModel [ 

]

{ #category : #accessing }
FylgjaNorthwindRuleInstaller >> fylgja: aFylgjaMigrationEngine [ 
	fylgja := aFylgjaMigrationEngine
]

{ #category : #general }
FylgjaNorthwindRuleInstaller >> installRules [
	 " nothing to do "

]

{ #category : #general }
FylgjaNorthwindRuleInstaller >> java: aModel [ 

]

{ #category : #general }
FylgjaNorthwindRuleInstaller >> map: aSource to: aTarget context: aContext mappings: aCollection [

	| mappings |
	mappings := Dictionary new.

	aCollection do: [ :map | 
		| sourceId targetId |
		sourceId := map key.
		targetId := map value.
		targetId isNumber
			ifFalse: [ 
			mappings at: targetId put: (aSource parameters at: sourceId) ]
			ifTrue: [ 
				mappings
					at: (aTarget parameters at: targetId)
					put: (aSource parameters at: sourceId) ] ].
	^ fylgja
		  map: aSource
		  to: aTarget
		  context: aContext
		  mapping: mappings
]

{ #category : #general }
FylgjaNorthwindRuleInstaller >> mapAll: aSourceCollection to: aTarget context: aContext mappings: aCollection [

	aSourceCollection do: [ :source | 
		self
			map: source
			to: aTarget
			context: aContext
			mappings: aCollection ]
]

{ #category : #general }
FylgjaNorthwindRuleInstaller >> northwind: aModel [ 
	northwind := aModel
]
