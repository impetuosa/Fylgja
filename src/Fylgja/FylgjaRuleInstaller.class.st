Class {
	#name : #FylgjaRuleInstaller,
	#superclass : #Object,
	#instVars : [
		'condition',
		'operation',
		'context',
		'installAtTopLevel'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #accessing }
FylgjaRuleInstaller >> all [
	self condition: FylgjaConditionAll new
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyEntity [

	self condition: FylgjaConditionAll new
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyEntityOfTypes: aCollection [

	self condition: (FylgjaConditionTypeIs new
			 types: aCollection;
			 yourself)
]

{ #category : #accessing }
FylgjaRuleInstaller >> build [
	^ (operation isMap
		   ifTrue: [ FylgjaMapRule new ]
		   ifFalse: [ FylgjaProductionRule new ])
		  condition: condition;
		  operation: operation;
		  yourself
]

{ #category : #accessing }
FylgjaRuleInstaller >> condition: aCondition [

	condition := aCondition
]

{ #category : #accessing }
FylgjaRuleInstaller >> context: aMOMethod [ 
	context := aMOMethod
]

{ #category : #accessing }
FylgjaRuleInstaller >> copy [

	self operation: FylgjaTranslateCopy new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsMethod [

	self operation: FylgjaTranslateCopyAsMethod new
]

{ #category : #accessing }
FylgjaRuleInstaller >> installAtTopLevel [

	^ installAtTopLevel ifNil: [ false ]
]

{ #category : #accessing }
FylgjaRuleInstaller >> installInto: aFylgja [

	| rule space |
	space := self installAtTopLevel
		         ifTrue: [ aFylgja mapspace ]
		         ifFalse: [ 
			         aFylgja mapspace
				         ensureNamespace: context
				         model: (self modelFor: aFylgja) ].
	rule := self build.
	self isMap
		ifTrue: [ space installMappingRule: rule ]
		ifFalse: [ space installProducingRule: rule ]
]

{ #category : #testing }
FylgjaRuleInstaller >> isMap [

	^ operation isMap
]

{ #category : #testing }
FylgjaRuleInstaller >> matchesPattern: aFylgjaPattern [

	self condition: aFylgjaPattern
]

{ #category : #hooks }
FylgjaRuleInstaller >> modelFor: aFylgjaModel [

	^ (context isKindOf: MOModel)
		  ifTrue: [ 
			  self assert: (aFylgjaModel models includes: context).
			  context ]
		  ifFalse: [ aFylgjaModel selectDestinationModelFor: context ]
]

{ #category : #accessing }
FylgjaRuleInstaller >> operation: anOperation [

	operation := anOperation
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> topLevel [
	installAtTopLevel := true .
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> whenEntityIs: anAlcixLocalVariable [

	self condition: (FylgjaConditionEntityEquality new
			 entity: anAlcixLocalVariable;
			 yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> whenEntityIsIdenticalTo: anAlcixLocalVariable [

	self condition: (FylgjaConditionEntityIdentity new
			 entity: anAlcixLocalVariable;
			 yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> whenType: aClass [

	self condition: (FylgjaConditionTypeIs new type: aClass)
]
