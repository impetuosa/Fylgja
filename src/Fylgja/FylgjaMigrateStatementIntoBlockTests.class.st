Class {
	#name : #FylgjaMigrateStatementIntoBlockTests,
	#superclass : #NotThatGoodTests,
	#category : #'Fylgja-Test'
}

{ #category : #'as yet unclassified' }
FylgjaMigrateStatementIntoBlockTests >> testProduceVariableIntoMethodByCopyNodeTransformDefault [

	| variable destinationContext result |
	variable := self logErrorFunctionVariable.
	destinationContext := self blockDataSourceConfigClassConfigPackage.

	FylgjaRuleInstaller new
		context: destinationContext;
		anyEntity;
		copy;
		installInto: fylgja.

	result := fylgja produce: variable into: destinationContext.
	self assert: (result result isKindOf: MOLocalVariable).
	self assert: result result language isJava.
	self
		assert: result result parent statements size
		equals: destinationContext statements size + 1.
	1 to: destinationContext statements size do: [ :i | 
		self assert: (result result parent statements at: i)
			== (destinationContext statements at: i) ].
	self assert:
		result result parent statements last name = variable name.
	self assert: result result parent statements last language isJava.
	self assert: result result parent statements last typeReference name
		= variable type name.

]

{ #category : #initialization }
FylgjaMigrateStatementIntoBlockTests >> testProduceVariableIntoMethodByCopyNodeTransformDefaultNoProducerFails [

	| variable destinationContext result |
	variable := self logErrorFunctionVariable.
	destinationContext := self dataSourceConfigClassConfigPackage.

	self
		should: [ 
		result := fylgja produce: variable into: destinationContext ]
		raise: NotFound
]
