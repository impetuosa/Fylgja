"
The tool is split in two areas: migrating tool and feedback. 

## Migrating tool: 

![resources/screenshot-tool.png](resources/screenshot-tool.png)

The figure depicts the central area of the migrating tool. 

1- Toolbar: tools for the project.
2- The left panel shows the structure and code of the MS Access project.
3- The right-top panel shows the structure and code of the Java-SpringBoot project.
4- The right-top panel shows the structure and code of the TypeScript-Angular project.

## Feedback area: 

In the bottom part of the tool we find three tabs.
1- Log 
This tab shows logs of the actions applied, informing errors and successes.

![resources/log.png](resources/log.png)

2- Rules 
Shows the rules valid in a selected context (a class by example)

![resources/rules.png](resources/rules.png)

3- Mappings
Shows the mappings and stubs tracked so far and valid in a given context.

![resources/mappings-stubs.png](resources/mappings-stubs.png)

##Using the tool.
The user can drag and drop a Declaration from one model to another. Once the drop is done, a popup asks the user to tell which directive she wants to apply: map or produce. In implementing the approach, we decided to allow the user to have different levels of control over the lookup of rules when applying the produce directive. 

(i) automatic lookup: the lookup uses the first found result. 
(ii) multiple choice: the lookup prompts the user to choose the rule to be applied. 
(iii) debugging: the lookup prompts the user to choose each rule.

In both (ii) and (iii) cases, the user chooses from all the rules available in the scope with positive conditions.

In the following images we find the GUI prompting the user to choose the rule to be applied in two different cases

![resources/screenshot-choose-rule.png](resources/screenshot-choose-rule.png).
![resources/screenshot-choose-rule1.png](resources/screenshot-choose-rule1.png).






"
Class {
	#name : #FylgjaAbstractUI,
	#superclass : #SpPresenter,
	#category : #'Fylgja-UI'
}

{ #category : #'instance creation' }
FylgjaAbstractUI class >> holdsPackageDocumentation [ 
	 ^ self = FylgjaAbstractUI 
]

{ #category : #private }
FylgjaAbstractUI >> application [

	^ application ifNil: [ owner application ]
]

{ #category : #private }
FylgjaAbstractUI >> controller [

	^ self application controller
]

{ #category : #private }
FylgjaAbstractUI >> initializePresenters [

	super initializePresenters.
	self registerToController
]

{ #category : #private }
FylgjaAbstractUI >> registerToController [
]

{ #category : #'as yet unclassified' }
FylgjaAbstractUI >> saveRules [

	self controller saveRules
]
