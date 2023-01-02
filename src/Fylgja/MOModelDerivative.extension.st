Extension { #name : #MOModelDerivative }

{ #category : #'*Fylgja' }
MOModelDerivative >> allStubs [
	^ self stubs , model allStubs
]

{ #category : #'*Fylgja' }
MOModelDerivative >> resolveModelUsing: aFylgjaDerivativeModel [

	self assert: (aFylgjaDerivativeModel derivativeModels includes: self).
	^ self
]

{ #category : #'*Fylgja' }
MOModelDerivative >> stubs [
	^ self entities select: [ : a | a isFylgjaStub ]
]
