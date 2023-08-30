Class {
	#name : #FylgjaAngularNgInit,
	#superclass : #FylgjaAngularModifications,
	#instVars : [
		'bindings',
		'service'
	],
	#category : #'Fylgja-Rule-Transformations'
}

{ #category : #'instance creation' }
FylgjaAngularNgInit class >> possibleWritingMessages [

	^ { #writeMethod: }
]

{ #category : #accessing }
FylgjaAngularNgInit >> bindings: aCollection [ 
	bindings := aCollection
]

{ #category : #'instance creation' }
FylgjaAngularNgInit >> privateApplyOn: aWriter [

	aWriter writeMethod: [ :method | 
		method selector: self selector.
		method returnTypeReference: (self returnTypeReferenceUsing: method).
		method writeBlock: [ :block | 
			bindings do: [ :binding | 
				block
					invokeMethodNamed: #subscribe
					receiver: [ :receiver | 
						receiver
							invokeMethodNamed: binding source daoAccessSelectorName
							receiver: [ :rex | 
							self variableReferenceTo: service using: rex ]
							arguments: [ :aex | {  } ] ]
					arguments: [ :aex | 
						{ (self
							 writeSetVariableLambda: (aWriter attributes detect: [ :a | 
									  a name = binding source daoAccessSelectorName ])
							 using: aex) } ] ] ] ]
]

{ #category : #accessing }
FylgjaAngularNgInit >> returnTypeReferenceUsing: class [

	^ class typeReferenceNamed: #void
]

{ #category : #accessing }
FylgjaAngularNgInit >> selector [ 
	^ #ngOnInit
		
]

{ #category : #accessing }
FylgjaAngularNgInit >> service: aMOAttribute [ 
	service := aMOAttribute
]

{ #category : #'instance creation' }
FylgjaAngularNgInit >> writeSetVariableLambda: anAttrtibute using: aex [

	^ aex writeLambda: [ :lambda | 
		  | data |
		  data := lambda writeParameter: [ :parameter | 
			          parameter name: #data ].
		  lambda writeBlock: [ :block | 
			  block writeStatement: [ :stmt | 
				  stmt
					  let: [ :lexp | 
					  self variableReferenceTo: anAttrtibute using: lexp ]
					  beAssignedWith: [ :assexp | 
					  self variableReferenceTo: data using: assexp ] ] ] ]
]
