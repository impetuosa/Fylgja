Class {
	#name : #FylgjaSuccessEntry,
	#superclass : #FylgjaLogEntry,
	#instVars : [
		'messageText'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #accessing }
FylgjaSuccessEntry >> icon [

	^ self iconNamed: #protocolPublic
]

{ #category : #accessing }
FylgjaSuccessEntry >> messageText [

	^ messageText
]

{ #category : #accessing }
FylgjaSuccessEntry >> messageText: aString [ 
	messageText := aString
]
