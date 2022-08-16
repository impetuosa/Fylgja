Class {
	#name : #FylgjaAddClass,
	#superclass : #FylgjaModification,
	#instVars : [
		'className',
		'superClassName'
	],
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #'instance creation' }
FylgjaAddClass class >> possibleWritingMessages [

	^ { #writeJavaClass:. #writeDeclarationUnit: }
]

{ #category : #accessing }
FylgjaAddClass >> className: aString [ 
	className := aString
]

{ #category : #'instance creation' }
FylgjaAddClass >> privateApplyOn: aWriter [

	^ aWriter acceptWritingVisitor: self
]

{ #category : #accessing }
FylgjaAddClass >> superClassName: aString [ 
	superClassName := aString
]

{ #category : #visiting }
FylgjaAddClass >> visitJavaClassWriter: aMOJavaClassWriter [

	| scn scp sc |
	scn := ('.' split: superClassName) last.
	scp := '.' join: ('.' split: superClassName) allButLast.

	sc := (aMOJavaClassWriter model allEntitiesSelect: [ :a | 
		       a isType and: [ 
			       a name = scn and: [ a packageReference name = scp ] ] ])
		      first.

	aMOJavaClassWriter writeJavaClass: [ :class | 
		class name: className.
		class superclassReference: ((class typeReferenceNamed: scn)
				 packageReference: (class packageReferenceNamed: scp);
				 candidate: sc;
				 yourself) ]
]

{ #category : #visiting }
FylgjaAddClass >> visitPackageWriter: aMOPackageWriter [

	^ aMOPackageWriter writeDeclarationUnit: [ :unit | 
		  unit acceptWritingVisitor: self ]
]

{ #category : #visiting }
FylgjaAddClass >> visitUnitWriter: aMODeclarationUnitWriter [

	| scn scp sc |
	scn := ('.' split: superClassName) last.
	scp := '.' join: ('.' split: superClassName) allButLast.

	sc := (aMODeclarationUnitWriter model allEntitiesSelect: [ :a | 
		       a isType and: [ 
			       a name = scn and: [ a packageReference name = scp ] ] ])
		      first.
	aMODeclarationUnitWriter writeJavaClass: [ :class | 
		class name: className.
		class superclassReference: ((class typeReferenceNamed: scn)
				 packageReference: (class packageReferenceNamed: scp);
				 candidate: sc;
				 yourself) ]
]
