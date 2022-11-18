Class {
	#name : #FylgjaTranslateCopyAsStMethod,
	#superclass : #FylgjaTranslateCopyAsMethod,
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #writing }
FylgjaTranslateCopyAsStMethod >> writeMethod: aDestinationWriter with: aBlock [

	^ aDestinationWriter writeStMethod: aBlock
]
