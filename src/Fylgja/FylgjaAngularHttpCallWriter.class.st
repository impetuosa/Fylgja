Class {
	#name : #FylgjaAngularHttpCallWriter,
	#superclass : #FylgjaAngularModifications,
	#instVars : [
		'endpoint',
		'http',
		'baseUrl',
		'parameters'
	],
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #'as yet unclassified' }
FylgjaAngularHttpCallWriter >> baseUrl: aMOAttribute [

	^ baseUrl := aMOAttribute
]

{ #category : #accessing }
FylgjaAngularHttpCallWriter >> endpoint: aString [ 
	endpoint := aString
]

{ #category : #'as yet unclassified' }
FylgjaAngularHttpCallWriter >> http: aMOAttribute [

	http := aMOAttribute
]

{ #category : #'instance creation' }
FylgjaAngularHttpCallWriter >> methodName [

	^ #get
]

{ #category : #accessing }
FylgjaAngularHttpCallWriter >> parameters: aCollection [ 
	parameters := aCollection
]

{ #category : #'instance creation' }
FylgjaAngularHttpCallWriter >> privateApplyOn: aMOBlockWriter [

	| serviceName |
	serviceName := ('/' split: endpoint) first.

	" http.get( '{this.baseUrl}/name=' )"

	^ aMOBlockWriter writeStatement: [ :stmt | 
		  stmt
			  invokeMethodNamed: self methodName
			  receiver: [ :exp | self variableReferenceTo: http using: exp ]
			  arguments: [ :exp | 
				  { (aMOBlockWriter templateLiteral: { 
						   (self variableReferenceTo: baseUrl using: exp).
						   (exp stringLiteral: '/' , serviceName , '/') }
					   , (parameters flatCollect: [ :p | 
							    { 
								    (self variableReferenceTo: p using: exp).
								    (exp stringLiteral: '/') } ])) } ] ]
]
