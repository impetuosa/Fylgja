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
FylgjaRule >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	^ operation
		  applyTo: aRelatedProvenanceEntity
		  croppingRelationsWith: aBlock
		  destinationWriter: aDestinationWriter
		  lookUp: aFylgjaLookUpContext
		  using: aFylgjaDerivativeModel
]

{ #category : #accessing }
FylgjaRule >> condition [
	^ condition
]

{ #category : #accessing }
FylgjaRule >> condition: aFylgjaConditionAll [ 
	condition := aFylgjaConditionAll
]

{ #category : #accessing }
FylgjaRule >> operation [
	^ operation
]

{ #category : #accessing }
FylgjaRule >> operation: aFylgjaTranslateCopy [ 
	operation := aFylgjaTranslateCopy 
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
