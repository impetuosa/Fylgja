Class {
	#name : #FylgjaSimpleMapping,
	#superclass : #FylgjaMapping,
	#instVars : [
		'engineSet'
	],
	#category : #'Fylgja-Rules'
}

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
