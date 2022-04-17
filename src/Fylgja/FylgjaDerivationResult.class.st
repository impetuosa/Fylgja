Class {
	#name : #FylgjaDerivationResult,
	#superclass : #Object,
	#instVars : [
		'derivative',
		'result'
	],
	#category : #'Fylgja-Model'
}

{ #category : #'as yet unclassified' }
FylgjaDerivationResult >> allNewEntities [

	^ derivative allNewEntities select: [ :a | 
		  a language = result language ]
]

{ #category : #accessing }
FylgjaDerivationResult >> derivative [
	^ derivative
]

{ #category : #accessing }
FylgjaDerivationResult >> derivative: aFylgjaDerivativeModel [ 
	derivative := aFylgjaDerivativeModel
]

{ #category : #accessing }
FylgjaDerivationResult >> entity [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FylgjaDerivationResult >> forceMap [
	^ derivative forceMap
]

{ #category : #accessing }
FylgjaDerivationResult >> map: aProvenanceEntity to: aDestinationEntity [

	derivative map: aProvenanceEntity to: aDestinationEntity
]

{ #category : #accessing }
FylgjaDerivationResult >> printOn: aStream [
  aStream
     nextPutAll: '#Result ';
     print: result
]

{ #category : #'as yet unclassified' }
FylgjaDerivationResult >> produce: aProvenanceEntity [

	^ self produce: aProvenanceEntity into: result
]

{ #category : #'as yet unclassified' }
FylgjaDerivationResult >> produce: aProvenanceEntity into: aDestinationContext [

	^ FylgjaDerivationResult new
		  derivative: derivative;
		  result:
			  (derivative produce: aProvenanceEntity into: aDestinationContext);
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaDerivationResult >> produceResultsCode [
	 ^ (result isKindOf: self class ) ifTrue: [ result  produceResultsCode ] ifFalse: [ result produceCode  ]
]

{ #category : #'as yet unclassified' }
FylgjaDerivationResult >> realResult [
	 ^ (result isKindOf: self class ) ifTrue: [ result realResult ] ifFalse: [ result  ]
]

{ #category : #accessing }
FylgjaDerivationResult >> result [
	^ result
]

{ #category : #accessing }
FylgjaDerivationResult >> result: aMOBlock [ 
	result := aMOBlock
]
