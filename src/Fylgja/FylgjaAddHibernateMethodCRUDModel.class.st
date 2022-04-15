Class {
	#name : #FylgjaAddHibernateMethodCRUDModel,
	#superclass : #FylgjaAddHibernateMethod,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddHibernateMethodCRUDModel >> applyOn: class [

	^ class writeMethod: [ :method | 
		  | parameter |
		  method returnTypeReference: (method typeReferenceNamed: #void).
		  method selector:
			  self crudSelector , modelTypeReference name capitalized.
		  method visibility: #public.
		  method returnTypeReference: (self booleanTypeReference: class).

		  parameter := method writeParameter: [ :model | 
			               model
				               name: 'a' , modelTypeReference name;
				               typeReference: modelTypeReference ].
		  method writeBlock: [ :block | 
			  | status |
			  status := FylgjaAddLocalVariable new
				            name: #status;
				            typeReference: (self booleanTypeReference: class);
				            initializer: (block booleanLiteral: false);
				            applyOn: block.

			  block writeTryCatch: [ :tryCatch | 
				  tryCatch writeTry: [ :tryBlock | 
					  tryBlock writeExpressionStatement: [ :stmt | 
						  stmt writeExpression: [ :exp | 
							  self
								  sendToCurrentSession: self crudSelector
								  using: parameter
								  into: exp ] ].
					  FylgjaAddAssignment new
						  read: (block booleanLiteral: true);
						  write: (self variableReferenceTo: status using: tryBlock);
						  applyOn: tryBlock ].
				  FylgjaAddCatchExceptionPrintStacktrace new applyOn: tryCatch ].
			  FylgjaAddReturn new
				  expression: (self variableReferenceTo: status using: block);
				  applyOn: block ] ]
]

{ #category : #'instance creation' }
FylgjaAddHibernateMethodCRUDModel >> crudSelector [

	^ self subclassResponsibility
]