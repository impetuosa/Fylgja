Class {
	#name : #FylgjaMRSInstaller,
	#superclass : #Object,
	#instVars : [
		'context',
		'installAtTopLevel',
		'installAtLanguageLevel'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #accessing }
FylgjaMRSInstaller >> atLanguageNamed: aString [ 
	installAtLanguageLevel := aString
]

{ #category : #accessing }
FylgjaMRSInstaller >> context: anInstallationContext [ 
	context := anInstallationContext
]

{ #category : #'as yet unclassified' }
FylgjaMRSInstaller >> installAtLanguageLevel [
	^ installAtLanguageLevel isNotNil
]

{ #category : #accessing }
FylgjaMRSInstaller >> installAtTopLevel [

	^ installAtTopLevel ifNil: [ false ]
]

{ #category : #'as yet unclassified' }
FylgjaMRSInstaller >> installingSpace: aFylgja [

	^ self installAtTopLevel
		  ifTrue: [ aFylgja migrationRuleSpace ]
		  ifFalse: [ 
			  self installAtLanguageLevel
				  ifTrue: [ 
					  aFylgja migrationRuleSpace subspaces detect: [ :languageSpaces | 
						  languageSpaces name = installAtLanguageLevel ] ]
				  ifFalse: [ 
					  aFylgja migrationRuleSpace
						  ensureNamespace: context
						  model: (self modelFor: aFylgja) ] ]
]

{ #category : #hooks }
FylgjaMRSInstaller >> modelFor: aFylgjaMigrationEngine [

	^ context resolveModelUsing: aFylgjaMigrationEngine
]

{ #category : #'as yet unclassified' }
FylgjaMRSInstaller >> topLevel [
	installAtTopLevel := true .
]
