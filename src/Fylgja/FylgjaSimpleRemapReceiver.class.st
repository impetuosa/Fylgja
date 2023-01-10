Class {
	#name : #FylgjaSimpleRemapReceiver,
	#superclass : #FylgjaStaticAdaptingRule,
	#instVars : [
		'mappings'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaSimpleRemapReceiver >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [

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
		            m hasReceiver and: [ 
			            (aDestinationEntity refersToObjectsLike: m target) not ] ].

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
		Sure there should be no arguments. If there are arguments it is an other price.
	 "

	(aDestinationEntity respondsTo: #arguments) ifTrue: [ 
		(mappings mapsArguments: aDestinationEntity arguments) ifTrue: [ 
			^ true ].
		^ (mappings source parameters size = 0 and: [ 
			   mappings target parameters size = 0 ])
			  ifTrue: [ true ]
			  ifFalse: [ false ] ].



	^ true
]
