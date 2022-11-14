Class {
	#name : #FylgjaTranslateCopyAsStClass,
	#superclass : #FylgjaTranslateCopyAsClass,
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #writing }
FylgjaTranslateCopyAsStClass >> writeClass: unit with: block [

	^ unit writeStClass: block
]
