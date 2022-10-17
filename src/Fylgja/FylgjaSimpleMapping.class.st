Class {
	#name : #FylgjaSimpleMapping,
	#superclass : #FylgjaMapping,
	#category : #'Fylgja-Rules'
}

{ #category : #'operators-mapping' }
FylgjaSimpleMapping >> map: aCollection [

	^ aCollection
]

{ #category : #'as yet unclassified' }
FylgjaSimpleMapping >> mapsArguments [
	^ false 
]

{ #category : #'as yet unclassified' }
FylgjaSimpleMapping >> mapsArguments: aCollection [

	^ aCollection isEmpty
]
