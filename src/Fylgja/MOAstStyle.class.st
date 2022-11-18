Class {
	#name : #MOAstStyle,
	#superclass : #Object,
	#category : #'Fylgja-UI-Text'
}

{ #category : #'as yet unclassified' }
MOAstStyle >> accessorKind [
	 ^ self keyword 
]

{ #category : #meta }
MOAstStyle >> annotation [

	^ { (self color: Color gray lighter lighter) }
]

{ #category : #converting }
MOAstStyle >> as [

	^ self keyword
]

{ #category : #'as yet unclassified' }
MOAstStyle >> assignmentKind [

	^ self keyword
]

{ #category : #'as yet unclassified' }
MOAstStyle >> bold [
	^ TextEmphasis bold
]

{ #category : #accessing }
MOAstStyle >> case [
	^ self keyword 
]

{ #category : #'as yet unclassified' }
MOAstStyle >> classStyle [
	 ^ self keyword
]

{ #category : #'as yet unclassified' }
MOAstStyle >> color: aColor [ 
	^ TextColor color: aColor 
]

{ #category : #'as yet unclassified' }
MOAstStyle >> colorForToken: aSmaCCCaseInsensitiveToken [ 
	^ { (self color: Color orange darker ) }
]

{ #category : #'as yet unclassified' }
MOAstStyle >> comment [

	^ { (self color: Color green muchDarker) }
]

{ #category : #generated }
MOAstStyle >> compare [
	^ self keyword 
]

{ #category : #'as yet unclassified' }
MOAstStyle >> const [

	^ self keyword
]

{ #category : #accessing }
MOAstStyle >> database [
	^ self keyword
]

{ #category : #'as yet unclassified' }
MOAstStyle >> dim [

	^ self keyword
]

{ #category : #generated }
MOAstStyle >> else [

	^ self keyword
]

{ #category : #'as yet unclassified' }
MOAstStyle >> endKeyword [

	^ self keyword 
]

{ #category : #accessing }
MOAstStyle >> enum [
	^ self keyword 
]

{ #category : #'accessing - styles' }
MOAstStyle >> errorStyle [
	^ self keyword 
]

{ #category : #'as yet unclassified' }
MOAstStyle >> explicit [

	^ self keyword
]

{ #category : #'as yet unclassified' }
MOAstStyle >> extends [
	 ^ self keyword
]

{ #category : #'as yet unclassified' }
MOAstStyle >> functionKeyword [

	^ self keyword 
]

{ #category : #'method - generated' }
MOAstStyle >> goto [
	^ self keyword 
]

{ #category : #generated }
MOAstStyle >> if [
	^ self keyword
]

{ #category : #'as yet unclassified' }
MOAstStyle >> implements [
	 ^ self keyword
]

{ #category : #accessing }
MOAstStyle >> keyword [

	^ { 
		  self bold.
		  (self color: Color blue darker) }
]

{ #category : #accessing }
MOAstStyle >> label [
	 ^ { self color: Color black . self bold  }
]

{ #category : #accessing }
MOAstStyle >> literal [

	^ { (self color: Color blue) }
]

{ #category : #generated }
MOAstStyle >> modifier [

	^ self keyword
]

{ #category : #'instance creation' }
MOAstStyle >> new [

	^ self keyword
]

{ #category : #accessing }
MOAstStyle >> next [

	^ self keyword
]

{ #category : #generated }
MOAstStyle >> on [
	^ self keyword
]

{ #category : #generated }
MOAstStyle >> operator [

	^ { (self color: Color red) }
]

{ #category : #accessing }
MOAstStyle >> option [
	^ self keyword 
]

{ #category : #accessing }
MOAstStyle >> package [
	^ self keyword
]

{ #category : #accessing }
MOAstStyle >> property [

	^ self keyword
]

{ #category : #controlling }
MOAstStyle >> resume [

	^ self keyword
]

{ #category : #'accessing - token' }
MOAstStyle >> return [

	^ self keyword
]

{ #category : #'brick-interactable-actions' }
MOAstStyle >> select [

	^ self keyword
]

{ #category : #accessing }
MOAstStyle >> string [

	^ { (self color: Color purple lighter lighter lighter) }
]

{ #category : #accessing }
MOAstStyle >> sub [

	^ self keyword
]

{ #category : #generated }
MOAstStyle >> then [
^ self keyword
]

{ #category : #generated }
MOAstStyle >> type [

	^ self keyword
]

{ #category : #'as yet unclassified' }
MOAstStyle >> visibility [

	^ self keyword
]

{ #category : #accessing }
MOAstStyle >> with [
	^ self keyword
]
