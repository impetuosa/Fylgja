Class {
	#name : #MOVBAStyle,
	#superclass : #Object,
	#category : #'Fylgja-UI'
}

{ #category : #'as yet unclassified' }
MOVBAStyle >> accessorKind [
	 ^ self keyword 
]

{ #category : #converting }
MOVBAStyle >> as [

	^ self keyword
]

{ #category : #'as yet unclassified' }
MOVBAStyle >> assignmentKind [

	^ self keyword
]

{ #category : #'as yet unclassified' }
MOVBAStyle >> bold [
	^ TextEmphasis bold
]

{ #category : #accessing }
MOVBAStyle >> case [
	^ self keyword 
]

{ #category : #'as yet unclassified' }
MOVBAStyle >> color: aColor [ 
	^ TextColor color: aColor 
]

{ #category : #'as yet unclassified' }
MOVBAStyle >> colorForToken: aSmaCCCaseInsensitiveToken [ 
	^ { (self color: Color orange darker ) }
]

{ #category : #'as yet unclassified' }
MOVBAStyle >> comment [

	^ { (self color: Color green muchDarker) }
]

{ #category : #generated }
MOVBAStyle >> compare [
	^ self keyword 
]

{ #category : #'as yet unclassified' }
MOVBAStyle >> const [

	^ self keyword
]

{ #category : #accessing }
MOVBAStyle >> database [
	^ self keyword
]

{ #category : #'as yet unclassified' }
MOVBAStyle >> dim [

	^ self keyword
]

{ #category : #generated }
MOVBAStyle >> else [

	^ self keyword
]

{ #category : #'as yet unclassified' }
MOVBAStyle >> endKeyword [

	^ self keyword 
]

{ #category : #accessing }
MOVBAStyle >> enum [
	^ self keyword 
]

{ #category : #'accessing - styles' }
MOVBAStyle >> errorStyle [
	^ self keyword 
]

{ #category : #'as yet unclassified' }
MOVBAStyle >> explicit [

	^ self keyword
]

{ #category : #'as yet unclassified' }
MOVBAStyle >> functionKeyword [

	^ self keyword 
]

{ #category : #'method - generated' }
MOVBAStyle >> goto [
	^ self keyword 
]

{ #category : #generated }
MOVBAStyle >> if [
	^ self keyword
]

{ #category : #accessing }
MOVBAStyle >> keyword [

	^ { 
		  self bold.
		  (self color: Color blue darker) }
]

{ #category : #accessing }
MOVBAStyle >> label [
	 ^ { self color: Color black . self bold  }
]

{ #category : #accessing }
MOVBAStyle >> literal [

	^ { (self color: Color blue) }
]

{ #category : #'instance creation' }
MOVBAStyle >> new [

	^ self keyword
]

{ #category : #accessing }
MOVBAStyle >> next [

	^ self keyword
]

{ #category : #generated }
MOVBAStyle >> on [
	^ self keyword
]

{ #category : #generated }
MOVBAStyle >> operator [

	^ { (self color: Color red) }
]

{ #category : #accessing }
MOVBAStyle >> option [
	^ self keyword 
]

{ #category : #accessing }
MOVBAStyle >> property [

	^ self keyword
]

{ #category : #controlling }
MOVBAStyle >> resume [

	^ self keyword
]

{ #category : #'brick-interactable-actions' }
MOVBAStyle >> select [

	^ self keyword
]

{ #category : #accessing }
MOVBAStyle >> string [

	^ { (self color: Color purple lighter lighter lighter) }
]

{ #category : #accessing }
MOVBAStyle >> sub [

	^ self keyword
]

{ #category : #generated }
MOVBAStyle >> then [
^ self keyword
]

{ #category : #generated }
MOVBAStyle >> type [

	^ self keyword
]

{ #category : #'as yet unclassified' }
MOVBAStyle >> visibility [

	^ self keyword
]

{ #category : #accessing }
MOVBAStyle >> with [
	^ self keyword
]
