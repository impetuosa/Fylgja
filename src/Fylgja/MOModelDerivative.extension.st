Extension { #name : #MOModelDerivative }

{ #category : #'*Fylgja' }
MOModelDerivative >> allStubs [
	^ entities select: [ : a | a isFylgjaStub ]
]

{ #category : #'*Fylgja' }
MOModelDerivative >> resolveModelUsing: aFylgjaDerivativeModel [

	self assert: (aFylgjaDerivativeModel derivativeModels includes: self).
	^ self
]
