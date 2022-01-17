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
FylgjaRuleInstaller >> anyInvocationTo: aString [

	self condition: (FylgjaConditionInvocationSelectorIs new
			 selector: aString;
			 yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyModelEntityOfTypes: aCollection [

	self condition: (FylgjaConditionModelTypeIs new
			 types: aCollection;
			 yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyTypeReferenceNamed: aString [

	self condition: (FylgjaConditionTypeReferenceIs new
			 typeName: aString;
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

{ #category : #copying }
FylgjaRuleInstaller >> copyAsTypesReferenceNamed: aString [

	^ self operation: (FylgjaTranslateCopyRenameTypeReference new
			   name: aString;
			   yourself)
]

{ #category : #accessing }
FylgjaRuleInstaller >> installAtTopLevel [

	^ installAtTopLevel ifNil: [ false ]
]

{ #category : #accessing }
FylgjaRuleInstaller >> installInto: aFylgja [

	| rule space |
	space := self installAtTopLevel
		         ifTrue: [ aFylgja migrationRuleSpace ]
		         ifFalse: [ 
			         aFylgja migrationRuleSpace
				         ensureNamespace: context
				         model: (self modelFor: aFylgja) ].
	rule := self build.
	self isMap
		ifTrue: [ space installMappingRule: rule ]
		ifFalse: [ 
			self isDelegate
				ifTrue: [ space installDelegatingRule: rule ]
				ifFalse: [ space installProducingRule: rule ] ]
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> invocationToMessageSend [

	self operation: FylgjaTranslateInvocationToMessageSend new.
	^ self operation
]

{ #category : #testing }
FylgjaRuleInstaller >> isDelegate [

	^ operation isDelegate
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
FylgjaRuleInstaller >> operation [
	^ operation
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
FylgjaRuleInstaller >> whenTypeOfModelEntityIs: aClass [

	self condition: (FylgjaConditionModelTypeIs new type: aClass)
]
