Class {
	#name : #FylgjaTranslateRewriteInvocation,
	#superclass : #FylgjaTranslate,
	#instVars : [
		'selector',
		'receiverBlock',
		'argumentCollectionTransform'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaTranslateRewriteInvocation >> receiverBlock: aFullBlockClosure [

	receiverBlock := aFullBlockClosure
]

{ #category : #accessing }
FylgjaTranslateRewriteInvocation >> selector: aString [

	selector := aString
]

{ #category : #'as yet unclassified' }
FylgjaTranslateRewriteInvocation >> withArgumentCollection: aFullBlockClosure [

	argumentCollectionTransform := aFullBlockClosure
]
