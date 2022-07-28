Class {
	#name : #FylgjaUIMigrateParentCommand,
	#superclass : #FylgjaUIMigrateCommand,
	#category : #'Fylgja-UI-Command-Migration'
}

{ #category : #testing }
FylgjaUIMigrateParentCommand >> canBeExecuted [

	^ (self context selectedItems allSatisfy: [ :first | 
		   first isFylgjaStub and: [ first candidate isNotNil ] ]) and: [ 
		  self singleParentIsDeclaration ]
]

{ #category : #testing }
FylgjaUIMigrateParentCommand >> extensionName [

	^ 'Parent'
]

{ #category : #testing }
FylgjaUIMigrateParentCommand >> passengers [

	^ (self context selectedItems collect: [ :c | 
		  c candidate parent ]) removeDuplicates 
]
