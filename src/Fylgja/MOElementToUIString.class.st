Class {
	#name : #MOElementToUIString,
	#superclass : #Object,
	#category : #'Fylgja-UI-Model'
}

{ #category : #'instance creation' }
MOElementToUIString >> doesNotUnderstand: aMessage [

	^ (aMessage arguments first respondsTo: #name)
		  ifTrue: [ 
			  aMessage arguments first name ifNil: [ 
				  aMessage arguments first printString ] ]
		  ifFalse: [ aMessage arguments first printString ]
]

{ #category : #visiting }
MOElementToUIString >> signature: aMethod [

	^ String streamContents: [ :str | 
		  str
			  nextPutAll: aMethod selector;
			  nextPutAll: '(';
			  nextPutAll: (',' split:
						   (aMethod parameters collect: [ :p | p acceptVisitor: self ]));
			  nextPutAll: ')';
			  nextPutAll: ':';
			  nextPutAll: (aMethod returnTypeReference
					   ifNil: [ #unknown ]
					   ifNotNil: [ :a | a name ]) ]
]

{ #category : #visiting }
MOElementToUIString >> signatureFunction: aMethod [

	^ String streamContents: [ :str | 
		  str
			  nextPutAll: aMethod selector;
			  nextPutAll: '(';
			  nextPutAll: (',' join:
						   (aMethod parameters collect: [ :p | p acceptVisitor: self ]));
			  nextPutAll: ')';
			  nextPutAll: ':';
			  nextPutAll: (aMethod returnTypeReference
					   ifNil: [ #unknown ]
					   ifNotNil: [ :a | a acceptVisitor: self ]) ]
]

{ #category : #visiting }
MOElementToUIString >> signatureProcedure: aMethod [

	^ String streamContents: [ :str | 
		  str
			  nextPutAll: aMethod selector;
			  nextPutAll: '(';
			  nextPutAll: (',' join:
						   (aMethod parameters collect: [ :p | p acceptVisitor: self ]));
			  nextPutAll: ')' ]
]

{ #category : #'instance creation' }
MOElementToUIString >> toString: anAssociation [

	| toVisit | 
	toVisit := anAssociation isAssociation
		           ifTrue: [ anAssociation value ]
		           ifFalse: [ anAssociation ].
	[ ^ toVisit acceptVisitor: self ] 
		on: Error
		do: [ self haltOnce ]
]

{ #category : #visiting }
MOElementToUIString >> visitArrayTypeReference: anArrayTypeReference [

	^ (anArrayTypeReference argumentTypeReferences first acceptVisitor:
		   self) , '[]'
]

{ #category : #visiting }
MOElementToUIString >> visitAttribute: anAttribute [
	
	^ anAttribute name , ' : ' ,( anAttribute typeReference
		  ifNotNil: [ :r | r name ifNil: [ #unknown ] ]
		  ifNil: [ #unknwon ])
]

{ #category : #visiting }
MOElementToUIString >> visitAttributeAccess: anAttributeAccess [

	^ anAttributeAccess printString
]

{ #category : #visiting }
MOElementToUIString >> visitClassFunction: aMethod [

	^ self signatureFunction: aMethod
]

{ #category : #visiting }
MOElementToUIString >> visitClassProcedure: aMethod [

	^ self signatureProcedure: aMethod
]

{ #category : #visiting }
MOElementToUIString >> visitForeignRelation: aMatch [

	^ '(PK)' , aMatch tableFrom printString , '=> (FK)'
	  , aMatch tableTo printString
]

{ #category : #visiting }
MOElementToUIString >> visitForeignRelationMatch: aMatch [

	^ aMatch primaryKey printString , ' => '
	  , aMatch foreignKey printString
]

{ #category : #visiting }
MOElementToUIString >> visitFunction: aMethod [

	^ self signatureFunction: aMethod
]

{ #category : #visiting }
MOElementToUIString >> visitMethod: aMethod [

	^ self signatureFunction: aMethod
]

{ #category : #visiting }
MOElementToUIString >> visitParameter: anAttribute [

	^ self visitAttribute: anAttribute
]

{ #category : #visiting }
MOElementToUIString >> visitProcedure: aMethod [

	^ self signatureProcedure: aMethod
]

{ #category : #visiting }
MOElementToUIString >> visitRootDeclaration: aMORootDeclaration [ 
	^ #root
]

{ #category : #visiting }
MOElementToUIString >> visitStatementExpression: aStatement [
	^ aStatement expression acceptVisitor: self
]

{ #category : #visiting }
MOElementToUIString >> visitTypeReference: aTypeReference [

	^ aTypeReference name ifNil: [ #Unknown ]
]
