Class {
	#name : #FylgjaStaticProductionRule,
	#superclass : #FylgjaStaticRule,
	#category : #'Fylgja-Rules'
}

{ #category : #testing }
FylgjaStaticProductionRule >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [
	 self subclassResponsibility 
]

{ #category : #testing }
FylgjaStaticProductionRule >> isProductionRule [

	^ true
]

{ #category : #testing }
FylgjaStaticProductionRule >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [
	 self subclassResponsibility 
]
