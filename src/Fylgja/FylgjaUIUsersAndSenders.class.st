Class {
	#name : #FylgjaUIUsersAndSenders,
	#superclass : #FylgjaUICommand,
	#category : #'Fylgja-UI-Commands'
}

{ #category : #'accessing - defaults' }
FylgjaUIUsersAndSenders class >> defaultName [

	^ 'Users & Senders'
]

{ #category : #testing }
FylgjaUIUsersAndSenders >> canBeExecuted [

	^ self context selectedItems isEmptyOrNil not and: [ 
		  self context selectedItems size = 1 and: [ 
			  { #users. #senders } anySatisfy: [ :s | 
				  self context selectedItems first respondsTo: s ] ] ]
]

{ #category : #testing }
FylgjaUIUsersAndSenders >> execute [

	^ MoxingSendersUsers new
		  usersOrSenders: (self context controller usersOrSenders:
					   self context selectedItems first);
		  open
]
