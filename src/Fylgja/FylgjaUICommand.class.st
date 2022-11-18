Class {
	#name : #FylgjaUICommand,
	#superclass : #CmCommand,
	#category : #'Fylgja-UI-Commands'
}

{ #category : #default }
FylgjaUICommand class >> addAsGroupNamed: aName into: rootCommandGroup for: presenterInstance [

	| group |
	group := (CmCommandGroup named: aName) asSpecGroup.
	self allSubclassesDo: [ :s | 
		group register: (s forSpecContext: presenterInstance) ].
	rootCommandGroup register: group.
	^ group
]

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
		           name: self name;
		           yourself.

	self class defaultShortcut ifNotNil: [ :keyCombination | 
		command shortcutKey: keyCombination ].

	^ command
]

{ #category : #converting }
FylgjaUICommand >> iconProvider [

	^ self application iconProvider
]
