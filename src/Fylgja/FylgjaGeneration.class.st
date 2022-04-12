Class {
	#name : #FylgjaGeneration,
	#superclass : #FylgjaProduction,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaGeneration >> importableDependencies: aMOClass [

	^ aMOClass dependencies select: [ :a | 
		  a packageReference isNotNil and: [ 
			  a packageReference name ~= 'java.lang' ] ]
]
