Class {
	#name : #MOJavaStyle,
	#superclass : #MOAstStyle,
	#category : #'Fylgja-UI-Text'
}

{ #category : #'instance creation' }
MOJavaStyle >> classStyle [ 
	 ^ self keyword
]

{ #category : #accessing }
MOJavaStyle >> keyword [

	^ { 
		  self bold.
		  (self color: Color red muchDarker ) }
]

{ #category : #'instance creation' }
MOJavaStyle >> literal [
 	^ { (self color: Color blue) }
]

{ #category : #'instance creation' }
MOJavaStyle >> new [ 
	 ^ {  self bold. (self color: Color blue muchDarker) }
]

{ #category : #'instance creation' }
MOJavaStyle >> type [ 
	 ^ { (self color: Color black muchDarker) }
]
