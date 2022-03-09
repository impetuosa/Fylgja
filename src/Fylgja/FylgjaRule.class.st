Class {
	#name : #FylgjaRule,
	#superclass : #Object,
	#instVars : [
		'condition',
		'operation'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #'as yet unclassified' }
FylgjaRule >> applyTo: anAlcixLocalVariable context: aMOMethod using: aFylgjaModel [

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
FylgjaRule >> applyTo: aRelatedProvenanceEntity destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	self subclassResponsibility
]

{ #category : #accessing }
FylgjaRule >> condition: aFylgjaConditionAll [ 
	condition := aFylgjaConditionAll
]

{ #category : #testing }
FylgjaRule >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType [

	^ condition
		  matches: aProvenanceEntityRelation
		  context: aDestinationContextRelation
		  forWriting: aType
]

{ #category : #accessing }
FylgjaRule >> printOn: aStream [
	aStream nextPutAll: 'if '.
	condition printOn: aStream. 
	aStream nextPutAll: ' '.
	aStream nextPutAll: self printingSymbol.
	aStream nextPutAll: ' '.
	operation printOn: aStream 
]

{ #category : #accessing }
FylgjaRule >> printingSymbol [
	^ self subclassResponsibility 
]

{ #category : #testing }
FylgjaRule >> priority [

	^ condition priority
]
