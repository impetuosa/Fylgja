Extension { #name : #MOModelDerivative }

{ #category : #'*Fylgja' }
MOModelDerivative >> resolveModelUsing: aFylgjaDerivativeModel [

	self assert: (aFylgjaDerivativeModel derivativeModels includes: self).
	^ self
]
