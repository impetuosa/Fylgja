Class {
	#name : #FylgjaNorthwindRuleInstaller,
	#superclass : #Object,
	#instVars : [
		'fylgja',
		'northwind'
	],
	#category : #'Fylgja-UI'
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
FylgjaNorthwindRuleInstaller >> northwind: aModel [ 
	northwind := aModel
]
