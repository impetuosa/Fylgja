Class {
	#name : #FylgjaSimpleRenameWithSameClassReceiverRule,
	#superclass : #FylgjaStaticAdaptingRule,
	#instVars : [
		'mappings',
		'expectedReceiver'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaSimpleRenameWithSameClassReceiverRule >> bind: aMOInvocation as: aMODeclarationStructuralRelation croppingRelationsWith: aFullBlockClosure destinationWriter: aMOModelWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [


	^ aMOModelWriter writeUnregisteredExpression: [ :expression | 
		  (expression
			   invokeMethodNamed: mappings target selector
			   receiver: [ :exp | 
				   expectedReceiver = #super
					   ifTrue: [ exp referenceToSuper ]
					   ifFalse: [ exp referenceToSelf ] ]
			   arguments: [ :exp | 
				   self mapArguments: aMOInvocation using: mappings ])
			  referee: mappings target;
			  yourself ]
]

{ #category : #'as yet unclassified' }
FylgjaSimpleRenameWithSameClassReceiverRule >> calculateReceiverFor: aMOMethod from: aMOClass [

	| current otherFindings methodParameterTypes currentMethod |
	current := aMOClass.
	otherFindings := 0.
	methodParameterTypes := aMOMethod parameters collect: [ :param | 
		                        param typeReference
			                        ifNil: [ '' ]
			                        ifNotNil: [ :t | t name ] ].
	[ 
	currentMethod := current methods
		                 detect: [ :method | 
			                 method selector = aMOMethod selector and: [ 
				                 method parameters size
				                 = aMOMethod parameters size and: [ 
					                 (method parameters collect: [ :param | 
						                  param typeReference
							                  ifNil: [ '' ]
							                  ifNotNil: [ :t | t name ] ])
					                 = methodParameterTypes ] ] ]
		                 ifNone: [ nil ] ] doWhileTrue: [ 
		(currentMethod
			 ifNotNil: [ 
				 (currentMethod isSameEntity: aMOMethod)
					 ifTrue: [ false ]
					 ifFalse: [ 
						 otherFindings := otherFindings + 1.
						 true ] ]
			 ifNil: [ true ])
			ifTrue: [ 
				current := current superclassReference referee.
				true ]
			ifFalse: [ false ] ].

	^ otherFindings = 0
		  ifTrue: [ #self ]
		  ifFalse: [ 
			  otherFindings = 1
				  ifTrue: [ #super ]
				  ifFalse: [ #impossible ] ]
]

{ #category : #'as yet unclassified' }
FylgjaSimpleRenameWithSameClassReceiverRule >> callingTo: aMOMethod canBeAchievedFrom: aMOJavaClass [

	^ (aMOJavaClass methods contains: [ :m | m isSameEntity: aMOMethod ]) 
		  or: [ 
			  aMOJavaClass superclassReference ifNil: [ false ] ifNotNil: [ 
				  aMOJavaClass superclassReference referee
					  ifNil: [ false ]
					  ifNotNil: [ :superclass | 
						  self callingTo: aMOMethod canBeAchievedFrom: superclass ] ] ]
]

{ #category : #testing }
FylgjaSimpleRenameWithSameClassReceiverRule >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [

	| callingMethod callingClass |
	" This is quite dangerous. mappings is an instance variable. 
 		We do so to ensure that the mapping used to accept the condition is the same used by the operation. 
		
		we rely on the fact that the operation is allways applied after the condition.
		And that there is not any kind of batch processing.  (like checking all the possible applications of these rule before applying )
	"
	aDestinationEntity parent isNil ifTrue: [ ^ false ].

	callingMethod := aDestinationEntity callingInvocable.
	callingMethod ifNil: [ ^ false ].
	callingMethod isMethod ifFalse: [ ^ false ].
	callingClass := callingMethod parent.

	mappings := aLookup resolveAllMappingsRelatedTo:
		            aCandidateRelation to.

	" We are interested on those elements that cannot be referred by the current reference. And which should refer to a static element.
	
	fn() --> Class.fn()
	"

	mappings := mappings select: [ :m | 
		            m hasReceiver not and: [ 
			            (aDestinationEntity refersToObjectsLike: m target) not 
				            and: [ 
					            m target isStaticBinding not and: [ 
						            self
							            callingTo: m target
							            canBeAchievedFrom: callingClass ] ] ] ].

	" 	
		There is one mapping leads to a destination that can be referred by our DestinationEntity. 
		Talking concrete: 
			If destination entity is a type reference without any argument, and a mapping yields a normal type, this condition is true. 
	 "

	mappings ifEmpty: [ ^ false ].
	self assert: mappings size = 1.
	mappings := mappings first.

	"By the time been i do not know what means to have more than one mapping. So here we are with an assertion to comeback whenever is needed "

	" 
		Sure there should be no arguments. 
		If there are arguments it is an other price.		
	"
	expectedReceiver := self
		                    calculateReceiverFor: mappings target
		                    from: callingClass.
	({ #super. #self } includes: expectedReceiver) ifFalse: [ ^ false ].

	(aDestinationEntity respondsTo: #arguments) ifTrue: [ 
		(mappings mapsArguments: aDestinationEntity arguments) ifTrue: [ 
			^ true ].
		^ (mappings source parameters size = 0 and: [ 
			   mappings target parameters size = 0 ])
			  ifTrue: [ true ]
			  ifFalse: [ false ] ].



	self halt
]

{ #category : #'as yet unclassified' }
FylgjaSimpleRenameWithSameClassReceiverRule >> printOn: aStream [
 	aStream nextPutAll: 'Rename reference to the declare artefact. Use this/super as receiver.'
]
