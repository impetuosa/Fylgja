Class {
	#name : #FylgjaTranslateCopyAsSelfFFICall,
	#superclass : #FylgjaTranslation,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsSelfFFICall >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [



  ^ aDestinationWriter writeExpression: [:expression |  
	expression invokeMethodNamed: #ffiCall: 
	receiver: [:re |  re referenceToSelf ] 
	arguments: [:argx |  {argx symbolicArrayLiteral:( OpalCompiler new evaluate: '#(' , aRelatedProvenanceEntity to arguments first literal,')')}] ]
]
