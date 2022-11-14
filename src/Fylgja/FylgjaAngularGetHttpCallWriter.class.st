Class {
	#name : #FylgjaAngularGetHttpCallWriter,
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
FylgjaAngularGetHttpCallWriter >> baseUrl: aMOAttribute [

	^ baseUrl := aMOAttribute
]

{ #category : #accessing }
FylgjaAngularGetHttpCallWriter >> endpoint: aString [ 
	endpoint := aString
]

{ #category : #'as yet unclassified' }
FylgjaAngularGetHttpCallWriter >> http: aMOAttribute [

	http := aMOAttribute
]

{ #category : #accessing }
FylgjaAngularGetHttpCallWriter >> parameters: aCollection [ 
	parameters := aCollection
]

{ #category : #'instance creation' }
FylgjaAngularGetHttpCallWriter >> privateApplyOn: aMOBlockWriter [

	| serviceName |
	serviceName := ('/' split: endpoint) first.

	" http.get( '{this.baseUrl}/name=' )"

	^ aMOBlockWriter writeStatement: [ :stmt | 
		  stmt
			  invokeMethodNamed: #get
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
