Class {
	#name : #FylgjaErrorEntry,
	#superclass : #FylgjaLogEntry,
	#instVars : [
		'exception'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #accessing }
FylgjaErrorEntry >> exception: anException [

	exception := anException
]

{ #category : #accessing }
FylgjaErrorEntry >> icon [

	^ self iconNamed: #protocolPrivate
]

{ #category : #accessing }
FylgjaErrorEntry >> messageText [
	 ^ exception messageText
]
