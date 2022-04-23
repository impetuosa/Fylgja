Class {
	#name : #FylgjaMapWarning,
	#superclass : #Warning,
	#instVars : [
		'errors',
		'fylgja',
		'mapper'
	],
	#category : #'Fylgja-ReadersWriters'
}

{ #category : #accessing }
FylgjaMapWarning >> mapper: aFylgjaReadMapper [ 
	mapper := aFylgjaReadMapper 
]

{ #category : #accessing }
FylgjaMapWarning >> signal [

	self messageText:
		('Warning: the reader mapper has found {1} mapping errors' format:
			 { mapper errors size }).
	super signal
]
