Class {
	#name : #FylgjaAddMethod,
	#superclass : #FylgjaModification,
	#instVars : [
		'returnTypeReference',
		'selector',
		'parameters'
	],
	#category : #'Fylgja-Rule-Transformations'
}

{ #category : #'instance creation' }
FylgjaAddMethod class >> possibleWritingMessages [

	^ { #writeMethod: }
]

{ #category : #accessing }
FylgjaAddMethod >> parameters [

	^ parameters ifNil: [ {  } ]
]

{ #category : #generated }
FylgjaAddMethod >> parameters: aCollection [

	parameters := aCollection
]

{ #category : #accessing }
FylgjaAddMethod >> returnTypeReference: aMOTypeReference [ 
	returnTypeReference := aMOTypeReference
]

{ #category : #accessing }
FylgjaAddMethod >> selector: aString [

	selector := aString.

]
