Class {
	#name : #FylgjaUIMigrateParentParentParentCommand,
	#superclass : #FylgjaUIMigrateCommand,
	#category : #'Fylgja-UI-Command-Migration'
}

{ #category : #testing }
FylgjaUIMigrateParentParentParentCommand >> canBeExecuted [

	^ (self context selectedItems allSatisfy: [ :first | 
		   first isFylgjaStub and: [ first referee isNotNil ] ]) and: [ 
		  self singleParentIsDeclaration ]
]

{ #category : #testing }
FylgjaUIMigrateParentParentParentCommand >> extensionName [

	^ 'Parent-Parent''s parent'
]

{ #category : #testing }
FylgjaUIMigrateParentParentParentCommand >> passengers [

	^ (self context selectedItems collect: [ :c | 
		  c referee parent parent parent ]) removeDuplicates 
]
