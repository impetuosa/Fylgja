Class {
	#name : #FylgjaDBEntityToSpring,
	#superclass : #FylgjaAccessToSpring,
	#instVars : [
		'block',
		'destinationWriter',
		'lookUp',
		'derivativeModel'
	],
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #testing }
FylgjaDBEntityToSpring >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [
	block := aBlock.
	lookUp := aFylgjaLookUpContext.
	derivativeModel := aFylgjaDerivativeModel.
	destinationWriter := aDestinationWriter
]

{ #category : #testing }
FylgjaDBEntityToSpring >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isDatasource and: [ 
		  self canWriteOver: aWriter ]
]
