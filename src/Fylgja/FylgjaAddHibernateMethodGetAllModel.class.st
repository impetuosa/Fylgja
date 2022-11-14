Class {
	#name : #FylgjaAddHibernateMethodGetAllModel,
	#superclass : #FylgjaAddHibernateMethod,
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #adding }
FylgjaAddHibernateMethodGetAllModel >> addCurrentSessionVariable: aString using: aMOBlockWriter [

	^ aMOBlockWriter writeVariable: [ :variable | 
		  | typeReference |
		  typeReference := self
			                   calculateTypeReference: #Session
			                   packageName: 'org.hibernate'
			                   using: variable.
		  variable name: aString.
		  variable typeReference: typeReference.

		  variable initializer: (variable writeExpression: [ :exp | 
				   exp
					   invokeMethodNamed: #getCurrentSession
					   receiver: [ :rexp | 
					   self variableReferenceTo: sessionFactory using: rexp ]
					   arguments: [ :e | {  } ] ]) ]
]

{ #category : #adding }
FylgjaAddHibernateMethodGetAllModel >> addGetResultList: aString model: aMOTypeReference delegatingTo: aMOLocalVariable into: aMOBlockWriter [

	^ aMOBlockWriter writeVariable: [ :variable | 
		  variable name: aString.
		  variable typeReference:
			  (self typeReferenceListOf: aMOTypeReference using: variable).
		  variable initializer: (variable writeExpression: [ :exp | 
				   exp
					   invokeMethodNamed: #getResultList
					   receiver: [ :e | 
					   self variableReferenceTo: aMOLocalVariable using: e ]
					   arguments: [ :e | {  } ] ]) ]
]

{ #category : #adding }
FylgjaAddHibernateMethodGetAllModel >> addQueryVariable: aName queryModel: aModelTypeReference queryString: aMOStringLiteral delegatingTo: aSessionVariable into: aMOBlockWriter [

	^ aMOBlockWriter writeVariable: [ :query | 
		  query name: aName.
		  query typeReference:
			  (self typeReferenceQueryOf: aModelTypeReference using: query).
		  query initializer: (query writeExpression: [ :exp | 
				   exp
					   invokeMethodNamed: #createQuery
					   receiver: [ :rexp | 
					   self variableReferenceTo: aSessionVariable using: rexp ]
					   arguments: [ :argexp | 
						   { 
							   aMOStringLiteral.
							   (argexp
								    accessAttribute: #class
								    receiver: [ :r | aModelTypeReference ]) } ] ]) ]
]

{ #category : #'instance creation' }
FylgjaAddHibernateMethodGetAllModel >> privateApplyOn: aClassWriter [

	^ aClassWriter writeMethod: [ :method | 
		  method selector: ('getAll{1}' format: { modelTypeReference name  }).
		  method returnTypeReference:
			  (self typeReferenceListOf: modelTypeReference using: method).
		  method writeBlock: [ :block | 
			  | currentSession query list |
			  currentSession := self
				                    addCurrentSessionVariable: #currentSession
				                    using: block.
			  query := self
				           addQueryVariable: #query
				           queryModel: modelTypeReference
				           queryString:
				           (block stringLiteral:
					            ('from {1}' format: { modelTypeReference name }))
				           delegatingTo: currentSession
				           into: block.

			  list := self
				          addGetResultList: #list
				          model: modelTypeReference
				          delegatingTo: query
				          into: block.
			  FylgjaAddReturn new
				  expression: (self variableReferenceTo: list using: block);
				  privateApplyOn: block ] ]
]
