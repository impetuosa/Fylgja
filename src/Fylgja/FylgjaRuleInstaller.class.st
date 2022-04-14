Class {
	#name : #FylgjaRuleInstaller,
	#superclass : #Object,
	#instVars : [
		'condition',
		'operation',
		'context',
		'installAtTopLevel',
		'installAtLanguageLevel'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #accessing }
FylgjaRuleInstaller >> all [

	^ self condition: FylgjaConditionAll new
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyAlceForm [

	^ self condition: (FylgjaConditionModelTypeIs new
			   type: MOAlceForm;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyAlceModule [

	^ self condition: (FylgjaConditionModelTypeIs new
			   type: MOModule;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyBindableEntity [
	^ self condition: (FylgjaConditionReferenceWithoutCandidate new)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyEntity [

	^ self condition: FylgjaConditionAll new
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyInvocation [

	^ self condition: (FylgjaConditionModelTypeIs new
			   type: MOInvocation;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyInvocationTo: aString [

	^ self condition: (FylgjaConditionInvocationSelectorIs new
			   selector: aString;
			   yourself) increasePriority
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyModelEntityOfTypesWhenGoingClass: aCollection [

	^ self condition: (FylgjaConditionModelTypeIsAndContextIs new
			   types: aCollection;
			   contextType: MOClass;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyOnErrorGoToBlockTransformableToTryCatch [

	^ self condition: FylgjaConditionOnErrorGoToBlockTransformableToTryCatch new
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyReferenceWithCandidate [

	^ self condition: FylgjaConditionReferenceWithCandidate new
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> anyTypeReferenceNamed: aString [

	^ self condition: (FylgjaConditionTypeReferenceIs new
			   typeName: aString;
			   yourself)
]

{ #category : #accessing }
FylgjaRuleInstaller >> atLanguageNamed: aString [ 
	installAtLanguageLevel := aString
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> binaryOperator: aString [

	^ self condition: (FylgjaConditionBinaryExpression new
			   operator: aString;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> bindRewriteTo: aDestinationEntity [

	^ self operation: (FylgjaBindRewrite new
			   destinationEntity: aDestinationEntity;
			   yourself)
]

{ #category : #accessing }
FylgjaRuleInstaller >> build [
	^ (operation isBinding
		   ifTrue: [ FylgjaBindingRule new ]
		   ifFalse: [ FylgjaProductionRule new ])
		  condition: condition;
		  operation: operation;
		  yourself
]

{ #category : #accessing }
FylgjaRuleInstaller >> condition: aCondition [

	condition := aCondition.
	^ condition
]

{ #category : #accessing }
FylgjaRuleInstaller >> context: anInstallationContext [ 
	context := anInstallationContext
]

{ #category : #accessing }
FylgjaRuleInstaller >> copy [

	self operation: FylgjaTranslateCopy new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsAttribute [

	self operation: FylgjaTranslateCopyAsAttribute new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsMethod [

	self operation: FylgjaTranslateCopyAsMethod new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsPublicClass [

	^ self operation: FylgjaTranslateCopyAsClass new
]

{ #category : #copying }
FylgjaRuleInstaller >> copyAsTypesReferenceNamed: aString [

	^ self operation: (FylgjaTranslateCopyRenameTypeReference new
			   name: aString;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> formToAngularComponent [

	^ self operation: FylgjaFormToAngularComponent new
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> formToAngularModel [

	^ self operation: FylgjaFormToAngularModel new
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> formToAngularService [ 

	^ self operation: FylgjaFormToAngularService new
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> formToSpringController: anUrl apiURLExtention: aString [

	^ self operation: (FylgjaFormToSpringController new
			   originURL: anUrl;
			   apiURLExtention: aString;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> formToSpringDAO [

	^ self operation: FylgjaFormToSpringDAO new
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> formToSpringModel [

	^ self operation: FylgjaFormToSpringModel new
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> formToSpringService [

	^ self operation: FylgjaFormToSpringService new
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> installAtLanguageLevel [
	^ installAtLanguageLevel isNotNil
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
			         self installAtLanguageLevel
				         ifTrue: [ 
					         aFylgja migrationRuleSpace subspaces detect: [ 
						         :languageSpaces | 
						         languageSpaces name = installAtLanguageLevel ] ]
				         ifFalse: [ 
					         aFylgja migrationRuleSpace
						         ensureNamespace: context
						         model: (self modelFor: aFylgja) ] ].
	rule := self build.
	self isBinding
		ifTrue: [ space installMappingRule: rule ]
		ifFalse: [ space installProducingRule: rule ]
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> invocationToMessageSend [

	self operation: FylgjaTranslateInvocationToMessageSend new.
	^ self operation
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> invocationToMessageSendToSelf [
	self invocationToMessageSend receiverBlock: [ :writer | 
		writer referenceToSelf ]
]

{ #category : #testing }
FylgjaRuleInstaller >> isBinding [

	^ operation isBinding
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> mappingStubInstall [

	self operation: FylgjaBindToLinkedStub new
]

{ #category : #testing }
FylgjaRuleInstaller >> matchesPattern: aFylgjaPattern [

	self condition: aFylgjaPattern
]

{ #category : #hooks }
FylgjaRuleInstaller >> modelFor: aFylgjaMigrationEngine [

	^ context resolveModelUsing: aFylgjaMigrationEngine
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> onErrorGoToToTryCatch [

	^ self operation: FylgjaCopyReplaceErrorGoToToTryCatch new 
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
FylgjaRuleInstaller >> prefixUnaryOperator: aString [

	^ self condition: (FylgjaConditionUnaryOperator new
			   operator: aString;
			   setAsPrefix;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> referenceNamed: aString [

	^ self condition: (FylgjaConditionReferenceNamed new
			   name: aString;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> replaceOperatorWith: aString [

	^ self operation: (FylgjaCopyReplaceBinaryOperator new
			   operator: aString;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> replacePrefixUnaryOperatorWith: aString [

	^ self operation: (FylgjaCopyReplaceUnaryOperator new
			   operator: aString;
			   setAsPrefix;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> replaceWithStringLiteral: aString [

	^ self operation: (FylgjaTranslateReplaceWithStringLiteral new
			   string: aString;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> returnSameBinding [

	^ self operation: FylgjaBindToSameBinding new
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> topLevel [
	installAtTopLevel := true .
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> whenEntityIs: anAlcixLocalVariable [

	^ self condition: (FylgjaConditionEntityEquality new
			   entity: anAlcixLocalVariable;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> whenEntityIsIdenticalTo: anAlcixLocalVariable [

	^ self condition: (FylgjaConditionEntityIdentity new
			   entity: anAlcixLocalVariable;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> whenIsReferenceWithCandidate: aProvenanceCandidate [

	^ self condition: (FylgjaConditionReferenceCandidateIs new
			   candidate: aProvenanceCandidate;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> whenIsReferenceWithCandidates:  someProvenanceCandidates [

	^ self condition: (FylgjaConditionReferenceCandidateIsAny new
			   candidates: someProvenanceCandidates;
			   yourself)
]

{ #category : #'as yet unclassified' }
FylgjaRuleInstaller >> whenTypeOfModelEntityIs: aClass [

	^ self condition: (FylgjaConditionModelTypeIsKindOf new type: aClass)
]
