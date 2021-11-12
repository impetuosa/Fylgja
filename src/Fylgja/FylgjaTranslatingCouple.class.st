Class {
	#name : #FylgjaTranslatingCouple,
	#superclass : #Object,
	#instVars : [
		'provenance',
		'destinationContainer',
		'destination'
	],
	#category : #'Fylgja-Test'
}

{ #category : #accessing }
FylgjaTranslatingCouple >> destination [
	^ destination
]

{ #category : #accessing }
FylgjaTranslatingCouple >> destinationContainer [
	^ destinationContainer
]

{ #category : #accessing }
FylgjaTranslatingCouple >> destinationContainer: aMOJavaClass [ 
	destinationContainer := aMOJavaClass
]

{ #category : #accessing }
FylgjaTranslatingCouple >> provenance [
	^ provenance
]

{ #category : #accessing }
FylgjaTranslatingCouple >> provenance: anAlcixFunction [ 
	provenance := anAlcixFunction
]
