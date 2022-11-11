Class {
	#name : #FylgjaUIMigrateParentParentCommand,
	#superclass : #FylgjaUIMigrateCommand,
	#category : #'Fylgja-UI-Command-Migration'
}

{ #category : #testing }
FylgjaUIMigrateParentParentCommand >> canBeExecuted [

	^ (self context selectedItems allSatisfy: [ :first | 
		   first isFylgjaStub and: [ first referee isNotNil ] ]) and: [ 
		  self singleParentIsDeclaration ]
]

{ #category : #testing }
FylgjaUIMigrateParentParentCommand >> extensionName [

	^ 'Parent''s parent'
]

{ #category : #testing }
FylgjaUIMigrateParentParentCommand >> passengers [

	^ (self context selectedItems collect: [ :c | 
		  c referee parent parent  ]) removeDuplicates 
]
