Class {
	#name : #FylgjaUIInspectObject,
	#superclass : #FylgjaUICommand,
	#category : #'Fylgja-UI-Commands'
}

{ #category : #'accessing - defaults' }
FylgjaUIInspectObject class >> defaultIconName [

	^ #glamorousInspect
]

{ #category : #'accessing - defaults' }
FylgjaUIInspectObject class >> defaultName [

	^ 'Inspect Object'
]

{ #category : #execution }
FylgjaUIInspectObject >> canBeExecuted [

	^ self context selectedItems size = 1 and: [ 
		  { 
			  MOAlceForm.
			  MOAlceReport } anySatisfy: [ :a | 
			  self context selectedItems first isKindOf: a ] ]
]

{ #category : #execution }
FylgjaUIInspectObject >> execute [

	^ MoxingObjectInspector new
		  model: self context selectedItems first object;
		  open
]
