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
FylgjaRuleInstaller >> installInto: aFylgja [
	self halt .
]

{ #category : #accessing }
FylgjaRuleInstaller >> operation: anOperation [

	operation := anOperation
]
