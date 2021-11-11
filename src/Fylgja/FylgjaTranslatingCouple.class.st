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
FylgjaTranslatingCouple >> destinationContainer: aMOJavaClass [ 
	destinationContainer := aMOJavaClass
]

{ #category : #accessing }
FylgjaTranslatingCouple >> provenance: anAlcixFunction [ 
	provenance := anAlcixFunction
]
