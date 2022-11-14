Class {
	#name : #FylgjaUIMigrateCommand,
	#superclass : #FylgjaUIMigrationCommand,
	#category : #'Fylgja-UI-Command-Migration'
}

{ #category : #'accessing - defaults' }
FylgjaUIMigrateCommand class >> defaultName [

	^ 'Migrate'
]

{ #category : #testing }
FylgjaUIMigrateCommand >> canBeExecuted [
	^ (self context selectedItems allSatisfy: [ :first | 
		   first isFylgjaStub and: [ first referee isDeclaration ] ]) 
		  and: [ self singleParent ]
]

{ #category : #executing }
FylgjaUIMigrateCommand >> execute [

	| transferMorph |
	transferMorph := TransferMorph
		                 withPassenger:  self passengers
		                 from:
		                 (self context withWidgetDo: [ :w | w widget ]).

	transferMorph
		align: transferMorph draggedMorph topLeft
		with:
		(self context withWidgetDo: [ :w | w widget ]) activeHand position.


	transferMorph dragTransferType: #dragTransfer.
	(self context withWidgetDo: [ :w | w widget ]) activeHand grabMorph:
		transferMorph
]

{ #category : #executing }
FylgjaUIMigrateCommand >> extensionName [

	^ ''
]

{ #category : #executing }
FylgjaUIMigrateCommand >> name [

	^ 'Migrate' , ' ' , (self canBeExecuted
		   ifTrue: [ 
			   (',' join: (self passengers collect: #name)) , ' ('
			   , (',' join: (self passengers collect: [ :a | a species name ]) removeDuplicates)
			   , ')' ]
		   ifFalse: [ self extensionName ])
]

{ #category : #executing }
FylgjaUIMigrateCommand >> passengers [

	^ (self context selectedItems collect: #referee) removeDuplicates
]

{ #category : #testing }
FylgjaUIMigrateCommand >> singleParent [

	^ (self context selectedItems collect: [ :s | s referee parent ]) removeDuplicates size
	  = 1
]

{ #category : #testing }
FylgjaUIMigrateCommand >> singleParentIsDeclaration [

	| prents |
	prents := (self context selectedItems collect: [ :s | 
		           s referee parent ]) removeDuplicates.
	^ prents size = 1 and: [ prents first isDeclarationOrDeclarationUnit ]
]
