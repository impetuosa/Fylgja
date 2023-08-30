"
SimpleMapping class.
"
Class {
	#name : #FylgjaSimpleMapping,
	#superclass : #FylgjaMapping,
	#instVars : [
		'engineSet'
	],
	#category : #'Fylgja-Mappings'
}

{ #category : #testing }
FylgjaSimpleMapping >> isEquivalentTo: aFylgjaSimpleMapping [
	
	^ self species = aFylgjaSimpleMapping species and: [ 
		  source anchor = aFylgjaSimpleMapping source anchor and: [ 
			  target anchor = aFylgjaSimpleMapping target anchor and: [ 
				  source name = aFylgjaSimpleMapping source name and: [ 
					  target name = aFylgjaSimpleMapping target name ] ] ] ]
]

{ #category : #initialization }
FylgjaSimpleMapping >> isSetByEngine [
	<doc:
	'Tests if the mapping is made or not automatically by the engine'>

	^ engineSet ifNil: [ false ]
]

{ #category : #'operators-mapping' }
FylgjaSimpleMapping >> map: aCollection [

	<doc:
	'Given a collection of arguments, returns a mapped collection them according to the parameter mapping. In the case of SimpleMapping, it returns the same collection of arguments. '>
	^ aCollection
]

{ #category : #'as yet unclassified' }
FylgjaSimpleMapping >> mapsArguments [

	^ self isSetByEngine
]

{ #category : #'as yet unclassified' }
FylgjaSimpleMapping >> mapsArguments: aCollection [

	^ aCollection isEmpty or: [ self isSetByEngine ]
]

{ #category : #initialization }
FylgjaSimpleMapping >> setAsEngine [
	<doc:
	'Sets the mapping to trace down the fact that it is a generated mapping, and not user made. '>

	^ engineSet := true
]
