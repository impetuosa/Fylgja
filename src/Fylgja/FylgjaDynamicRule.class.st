Class {
	#name : #FylgjaDynamicRule,
	#superclass : #FylgjaAbstractRule,
	#instVars : [
		'condition',
		'operation'
	],
	#category : #'Fylgja-Rules'
}

{ #category : #accessing }
FylgjaDynamicRule >> condition [
	^ condition
]

{ #category : #accessing }
FylgjaDynamicRule >> condition: aFylgjaConditionAll [ 
	condition := aFylgjaConditionAll
]

{ #category : #accessing }
FylgjaDynamicRule >> operation [
	^ operation
]

{ #category : #accessing }
FylgjaDynamicRule >> operation: aFylgjaTranslateCopy [ 
	operation := aFylgjaTranslateCopy 
]

{ #category : #accessing }
FylgjaDynamicRule >> printOn: aStream [
	aStream nextPutAll: 'if '.
	condition printOn: aStream. 
	aStream nextPutAll: ' '.
	aStream nextPutAll: self printingSymbol.
	aStream nextPutAll: ' '.
	operation printOn: aStream 
]

{ #category : #accessing }
FylgjaDynamicRule >> printingSymbol [
	^ self subclassResponsibility 
]

{ #category : #testing }
FylgjaDynamicRule >> priority [

	^ condition priority
]
