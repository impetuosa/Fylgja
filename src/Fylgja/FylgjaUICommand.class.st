Class {
	#name : #FylgjaUICommand,
	#superclass : #CmCommand,
	#category : #'Fylgja-UI-Commands'
}

{ #category : #default }
FylgjaUICommand class >> defaultIconName [

	^ ''
]

{ #category : #default }
FylgjaUICommand class >> defaultShortcut [

	^ nil
]

{ #category : #testing }
FylgjaUICommand class >> isAbstract [

	^ self = FylgjaUICommand
]

{ #category : #converting }
FylgjaUICommand >> application [

	^ context application
]

{ #category : #converting }
FylgjaUICommand >> asSpecCommand [

	| command |
	command := super asSpecCommand
		           iconProvider: self iconProvider;
		           iconName: self class defaultIconName;
		           name: self class defaultName;
		           yourself.

	self class defaultShortcut ifNotNil: [ :keyCombination | 
		command shortcutKey: keyCombination ].

	^ command
]

{ #category : #converting }
FylgjaUICommand >> iconProvider [

	^ self application iconProvider
]
