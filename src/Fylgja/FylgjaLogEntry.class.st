Class {
	#name : #FylgjaLogEntry,
	#superclass : #Object,
	#instVars : [
		'stamp',
		'operation'
	],
	#category : #'Fylgja-UI-Widgets'
}

{ #category : #accessing }
FylgjaLogEntry >> icon [

	^ self subclassResponsibility
]

{ #category : #accessing }
FylgjaLogEntry >> initialize [ 
	super initialize.
	stamp := DateAndTime now.
]

{ #category : #accessing }
FylgjaLogEntry >> messageText [

	self subclassResponsibility
]

{ #category : #accessing }
FylgjaLogEntry >> operation [
	 ^ operation 
]

{ #category : #accessing }
FylgjaLogEntry >> operation: anOperationName [

	operation := anOperationName
]

{ #category : #accessing }
FylgjaLogEntry >> stamp [

	^ stamp
]
