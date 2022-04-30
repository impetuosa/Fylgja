Extension { #name : #MOModelDerivative }

{ #category : #'*Fylgja' }
MOModelDerivative >> allStubs [
	^ self entities select: [ : a | a isFylgjaStub ]
]

{ #category : #'*Fylgja' }
MOModelDerivative >> resolveModelUsing: aFylgjaDerivativeModel [

	self assert: (aFylgjaDerivativeModel derivativeModels includes: self).
	^ self
]
