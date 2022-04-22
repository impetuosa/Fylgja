Class {
	#name : #FylgjaOperationMultiply,
	#superclass : #FylgjaOperation,
	#instVars : [
		'subdestinations',
		'destinations'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #accessing }
FylgjaOperationMultiply >> destinations: aCollection [

	destinations := aCollection
]
