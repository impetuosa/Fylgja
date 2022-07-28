Class {
	#name : #FylgjaAddPackage,
	#superclass : #FylgjaModification,
	#instVars : [
		'packageName'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #accessing }
FylgjaAddPackage >> packageName: aString [ 
	packageName := aString
]

{ #category : #'instance creation' }
FylgjaAddPackage >> possibleWritingMessages [

	^ { #writePackage: }
]

{ #category : #'instance creation' }
FylgjaAddPackage >> privateApplyOn: aWriter [

	^ aWriter writePackage: [ :package | package name: packageName ]
]