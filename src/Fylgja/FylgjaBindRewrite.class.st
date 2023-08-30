Class {
	#name : #FylgjaBindRewrite,
	#superclass : #FylgjaBinding,
	#instVars : [
		'destinationEntity'
	],
	#category : #'Fylgja-Rule-BindingOperations'
}

{ #category : #'as yet unclassified' }
FylgjaBindRewrite >> bind: aDestinationEntity as: aCandidateRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgja [

	^ self rewriter
		  bind: aDestinationEntity
		  to: destinationEntity
		  semanticallyEquivalentTo: aCandidateRelation
		  destinationWriter: aDestinationWriter
		  lookUp: aFylgjaLookUpContext
		  using: aFylgja
]

{ #category : #'as yet unclassified' }
FylgjaBindRewrite >> destinationEntity: aDestinationEntity [

	destinationEntity := aDestinationEntity
]

{ #category : #'as yet unclassified' }
FylgjaBindRewrite >> printOn: aStream [

	aStream
		nextPutAll: 'Bind-Rewrite(';
		print: destinationEntity;
		nextPutAll: ')'
]

{ #category : #accessing }
FylgjaBindRewrite >> rewriter [
	^  FylgjaBindNameBasedRewriter new .
]
