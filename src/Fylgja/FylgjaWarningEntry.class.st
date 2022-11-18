Class {
	#name : #FylgjaWarningEntry,
	#superclass : #FylgjaLogEntry,
	#instVars : [
		'messageText'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #accessing }
FylgjaWarningEntry >> icon [

	^ self iconNamed: #protocolProtected
]

{ #category : #accessing }
FylgjaWarningEntry >> messageText [

	^ messageText
]

{ #category : #accessing }
FylgjaWarningEntry >> messageText: aString [ 
	messageText := aString
]
