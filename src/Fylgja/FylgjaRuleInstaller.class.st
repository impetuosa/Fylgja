Class {
	#name : #FylgjaRuleInstaller,
	#superclass : #Object,
	#instVars : [
		'condition',
		'operation',
		'context'
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

{ #category : #accessing }
FylgjaRuleInstaller >> installInto: aFylgja [

	| rule space |
	space := aFylgja mapspace
		         ensureNamespace: context
		         model: (aFylgja selectDestinationModelFor: context).
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

{ #category : #accessing }
FylgjaRuleInstaller >> operation: anOperation [

	operation := anOperation
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
