Class {
	#name : #FylgjaUIAddPackage,
	#superclass : #FylgjaUIDeclarationCommand,
	#category : #'Fylgja-UI-Command-Model'
}

{ #category : #'accessing - defaults' }
FylgjaUIAddPackage class >> defaultName [

	^ 'Add Package'
]

{ #category : #accessing }
FylgjaUIAddPackage >> canBeExecuted [
	^ self context selectedItems isEmptyOrNil not and: [ 
		  self context selectedItems allSatisfy: [ :a | 
			  { 
				  MOModel.
				  MORootDeclaration } anySatisfy: [ :t | a isKindOf: t ] ] ]
]

{ #category : #executing }
FylgjaUIAddPackage >> execute [

	| packageName |
	packageName := UIManager default
		               request: 'Package name'
		               initialAnswer: 'example.package.name'.
	self apply: [ :elem :destinationWriter | 
		FylgjaAddPackage new
			packageName: packageName;
			applyOn: destinationWriter ]
]
