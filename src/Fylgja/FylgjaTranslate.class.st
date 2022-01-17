Class {
	#name : #FylgjaTranslate,
	#superclass : #FylgjaProduce,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslate >> applyTo: aProvenanceEntity context: aDestinationContext using: aFylgjaDerivativeModel [

	self subclassResponsibility 
]

{ #category : #testing }
FylgjaTranslate >> isDelegate [
	^ false 
]
