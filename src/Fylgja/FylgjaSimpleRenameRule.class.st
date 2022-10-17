Class {
	#name : #FylgjaSimpleRenameRule,
	#superclass : #FylgjaStaticAdaptingRule,
	#instVars : [
		'mappings'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaSimpleRenameRule >> bind: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	| referee |

	self assert: mappings isNotNil. 
	
	referee := mappings target.
	aCandidateRelation write: referee to: aDestinationEntity.
	aDestinationEntity name: referee name.
	
	mappings := nil.
	^ aDestinationEntity
]

{ #category : #testing }
FylgjaSimpleRenameRule >> matches: aDestinationEntity context: aDestinationContextRelation toBindAs: aCandidateRelation consideringMappingsFrom: aLookup [

	" This is quite dangerous. mappings is an instance variable. 
 		We do so to ensure that the mapping used to accept the condition is the same used by the operation. 
		
		we rely on the fact that the operation is allways applied after the condition.
		And that there is not any kind of batch processing.  (like checking all the possible applications of these rule before applying )
	"

	mappings := aLookup resolveAllMappingsRelatedTo:
		            aCandidateRelation to.
	mappings := mappings select: [ :m | 
		            aDestinationEntity refersToObjectsLike: m target ].

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
		mappings source parameters size = mappings target parameters size 
			ifFalse: [ ^ false ].
		self halt ].

	^ true
]
