Class {
	#name : #FylgjaTranslateCopyAsSelfFFICall,
	#superclass : #FylgjaTranslation,
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsSelfFFICall class >> possibleWritingMessages [

	^ { #writeReturn: }
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsSelfFFICall >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [
	| symbolic | 
	symbolic := (OpalCompiler new evaluate: '#(' , aRelatedProvenanceEntity to expression arguments first literal , ')').
  ^aDestinationWriter writeReturn: [:r |  
		r writeExpression: [:expression |  
			expression invokeMethodNamed: #ffiCall: 
			receiver: [:re |  re referenceToSelf ] 
			arguments: [:argx |  
				{(argx symbolicArrayLiteral: symbolic )} ] ] ]
]

{ #category : #'as yet unclassified' }
FylgjaTranslateCopyAsSelfFFICall >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isPragma and: [ 
		  self canWriteOver: aWriter ]
]
