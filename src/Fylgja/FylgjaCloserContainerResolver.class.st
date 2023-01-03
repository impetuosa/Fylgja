Class {
	#name : #FylgjaCloserContainerResolver,
	#superclass : #Object,
	#category : #'Fylgja-Model'
}

{ #category : #resolving }
FylgjaCloserContainerResolver >> resolve: aMOJavaClass [

	^ aMOJavaClass acceptVisitor: self
]

{ #category : #visiting }
FylgjaCloserContainerResolver >> visitDeclarationUnit: aMODeclarationUnit [

	^ aMODeclarationUnit parent acceptVisitor: self
]

{ #category : #visiting }
FylgjaCloserContainerResolver >> visitJavaClass: aMOJavaClass [

	^ aMOJavaClass parent acceptVisitor: self
]

{ #category : #visiting }
FylgjaCloserContainerResolver >> visitPackage: aMOPackage [

	^ aMOPackage
]
