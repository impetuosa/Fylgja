Class {
	#name : #FylgjaSimpleMapping,
	#superclass : #FylgjaMapping,
	#instVars : [
		'engineSet'
	],
	#category : #'Fylgja-Rules'
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

	^ engineSet ifNil: [ false ]
]

{ #category : #'operators-mapping' }
FylgjaSimpleMapping >> map: aCollection [

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

	^ engineSet := true
]
