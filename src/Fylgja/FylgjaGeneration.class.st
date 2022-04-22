Class {
	#name : #FylgjaGeneration,
	#superclass : #FylgjaProduction,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaGeneration >> addAttribute: attr boundAs: instance croppingRelationsWith: aBlock destinationWriter: class lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| typeReference |
	typeReference := FylgjaMigrate new
		                 cropping: aBlock;
		                 fylgja: aFylgjaDerivativeModel;
		                 lookUp: aFylgjaLookUpContext;
		                 provenanceEntity: attr typeReference;
		                 applyOn: class.



	^ FylgjaAddAttribute new
		  visibility: #public;
		  name: attr name;
		  typeReference: typeReference;
		  applyOn: class
]

{ #category : #'as yet unclassified' }
FylgjaGeneration >> importableDependencies: aMOClass [

	^ aMOClass dependencies select: [ :a | 
		  a packageReference isNotNil and: [ 
			  a packageReference name ~= 'java.lang' ] ]
]
