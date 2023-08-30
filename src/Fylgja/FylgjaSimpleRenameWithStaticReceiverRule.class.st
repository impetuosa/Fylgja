Class {
	#name : #FylgjaSimpleRenameWithStaticReceiverRule,
	#superclass : #FylgjaStaticAdaptingRule,
	#instVars : [
		'mappings'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaSimpleRenameWithStaticReceiverRule >> bind: aMOInvocation as: aMODeclarationStructuralRelation croppingRelationsWith: aFullBlockClosure destinationWriter: aMOModelWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	<doc: 'Operation:
1. Define a method invocation expression (a reference) using the method’s parent as a receiver.
2. Set the arguments used by the function invocation in the new method invocation.
3. Set the new target reference to the mapped target declaration.
'>
	^ aMOModelWriter writeUnregisteredExpression: [ :expression | 
		  mappings target isMethod
			  ifTrue: [ 
				  (expression
					   invokeMethodNamed: mappings target selector
					   receiver: [ :exp | 
						   (exp typeReferenceNamedForRebinding:
								    mappings target parent name)
							   referee: mappings target parent;
							   yourself ]
					   arguments: [ :exp | 
					   self mapArguments: aMOInvocation using: mappings ])
					  referee: mappings target;
					  yourself ]
			  ifFalse: [ "				  self assert: mappings mapsArguments not."
				  expression
					  accessAttribute: mappings target name
					  receiver: [ :exp | 
						  (exp typeReferenceNamedForRebinding:
								   mappings target parent name)
							  referee: mappings target parent;
							  yourself ] ] ]
]

{ #category : #testing }
FylgjaSimpleRenameWithStaticReceiverRule >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [
<doc:	'Condition:
1. The target reference is a function invocation AND 
2. The given map target declaration is a method AND 3. The given map target declaration is static.'>
	" This is quite dangerous. mappings is an instance variable. 
 		We do so to ensure that the mapping used to accept the condition is the same used by the operation. 
		
		we rely on the fact that the operation is allways applied after the condition.
		And that there is not any kind of batch processing.  (like checking all the possible applications of these rule before applying )
	"
	mappings := aLookup resolveAllMappingsRelatedTo:
		            aCandidateRelation to.

	" We are interested on those elements that cannot be referred by the current reference. And which should refer to a static element.
	
	fn() --> Class.fn()
	"
	mappings := mappings select: [ :m | 
		            m hasReceiver not and: [ 
			            (aDestinationEntity refersToObjectsLike: m target) not 
				            and: [ m target isStaticBinding ] ] ].

	" 	
		There is one mapping leads to a destination that can be referred by our DestinationEntity. 
		Talking concrete: 
			If destination entity is a type reference without any argument, and a mapping yields a normal type, this condition is true. 
	 "

	mappings ifEmpty: [ ^ false ].
"	self assert: mappings size = 1."
	mappings := mappings first.
	"By the time been i do not know what means to have more than one mapping. So here we are with an assertion to comeback whenever is needed "

	" 	
		Sure there should be no arguments. If there are arguments it is an other price.
	 "

	(aDestinationEntity respondsTo: #arguments) ifTrue: [ 
		(mappings mapsArguments: aDestinationEntity arguments) ifTrue: [ ^ true ].
		^ (mappings source parameters size = 0 and: [ 
			   mappings target parameters size = 0 ])
			  ifTrue: [ true ]
			  ifFalse: [ false ] ].



	^ true
]

{ #category : #testing }
FylgjaSimpleRenameWithStaticReceiverRule >> printOn: aStream [
 	aStream nextPutAll: 'Rename reference to the declare artefact. Use static class as receiver.'
]
