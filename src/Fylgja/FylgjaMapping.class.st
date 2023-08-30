"
#Mappings

Mappings are evidence of semantic equivalence. By semantic equivalence we mean that a source entity is equivalent to a target entity. A mapping can be the outcome of the user manually configuring the engine. It can also be the engine’s outcome establishing a relationship between two entities. 
We distinguish two kinds of mappings: Simple and nested.

- Simple mapping relates a source declaration with a target declaration. 	It works as a simple association, implying that the source declaration is equivalent to the target declaration in the target ASG. This mapping is enough to map two entities without parameters or two target entity that was produced based on the source entity (assuming that if there are parameters, they did not change order).  eg (Void => void); (String => String); etc. 
- Nested mapping associates a source declaration with a target declaration and the parameters between source and target declarations. This mapping also specifies if a parameter on the source declaration becomes a receiver in the target. eg let's consider the mapping between function F(x,y,z) and method M(a,b,c). 
Three  mappings examples could be: 

**(F => M (a => z; b => y; c => x))**: all the target parameters are mapped to all source parameters. The order changes.

**(F=>M(a=>x;b=>y;c=>x))**: parameters a and c are mapped to x; parameter b is mapped to a. Parameter z is dismissed.

**(F=>M(a=>x;b=>y;c=>x;z=>R))**: parameters a and c are mapped to x; parameter b is mapped to a. Parameter z is proposed as a receiver.



"
Class {
	#name : #FylgjaMapping,
	#superclass : #Object,
	#instVars : [
		'source',
		'target'
	],
	#category : #'Fylgja-Mappings'
}

{ #category : #'as yet unclassified' }
FylgjaMapping class >> holdsPackageDocumentation [

	^ true
]

{ #category : #testing }
FylgjaMapping >> hasReceiver [

	^ false
]

{ #category : #testing }
FylgjaMapping >> isInvocable [

	^ false
]

{ #category : #testing }
FylgjaMapping >> isInvocation [

	^ false
]

{ #category : #testing }
FylgjaMapping >> isStatement [

	^ false
]

{ #category : #testing }
FylgjaMapping >> isStatementExpression [

	^ false
]

{ #category : #testing }
FylgjaMapping >> isTypeReference [

	^ false
]

{ #category : #testing }
FylgjaMapping >> isVariable [

	^ false
]

{ #category : #accessing }
FylgjaMapping >> mappingString [
	 ^ self targetName 
]

{ #category : #'as yet unclassified' }
FylgjaMapping >> mapsArguments [

	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
FylgjaMapping >> mapsSource: aMOLocalVariable [
	<doc: 'Tests if this mapping is using something like the parameter as source (Source => Target).'>
	^ source isSameEntity: aMOLocalVariable
]

{ #category : #accessing }
FylgjaMapping >> printOn: aStream [

	aStream
		nextPutAll: self sourceName;
		nextPutAll: ' => ';
		nextPutAll: self targetName
]

{ #category : #accessing }
FylgjaMapping >> source [

	^ source
]

{ #category : #accessing }
FylgjaMapping >> source: anObject [ 
	<doc: 'It sets the source of the mapping. For the association (Source => Target), we are setting Source. '>
	source := anObject
]

{ #category : #accessing }
FylgjaMapping >> sourceName [

	| parentName sourceName |
	parentName := (source parent respondsTo: #name)
		              ifFalse: [ source parent printString ]
		              ifTrue: [ 
			              (source parentName
				               includesSubstring: 'paper'
				               caseSensitive: false)
				              ifTrue: [ #VBALang ]
				              ifFalse: [ source parent name ] ].
	sourceName := (source respondsTo: #name)
		              ifTrue: [ source name ]
		              ifFalse: [ source className ].

	^ String streamContents: [ :str | 
		  str
			  nextPutAll: (source isType
					   ifTrue: [ 'T' ]
					   ifFalse: [ 
						   (source isKindOf: MOInvocable)
							   ifTrue: 'I'
							   ifFalse: 'V' ]);
			  nextPutAll: ';'.
		  str
			  nextPutAll: parentName;
			  nextPutAll: '.';
			  nextPutAll: sourceName ]
]

{ #category : #accessing }
FylgjaMapping >> target [

	^ target
]

{ #category : #accessing }
FylgjaMapping >> target: anObject [
		<doc: 'It sets the target of the mapping. For the association (Source => Target), we are setting Target. '>
	target := anObject
]

{ #category : #accessing }
FylgjaMapping >> targetName [

	| tn |
	tn := (target respondsTo: #name)
		      ifTrue: [ target name ]
		      ifFalse: [ tn className ].
	^ String streamContents: [ :str | 
		  str
			  nextPutAll: (target isType
					   ifTrue: [ 'T' ]
					   ifFalse: [ 
						   (source isKindOf: MOInvocable)
							   ifTrue: 'I'
							   ifFalse: 'V' ]);
			  nextPutAll: ';'.
		  str
			  nextPutAll: target parentName;
			  nextPutAll: '.';
			  nextPutAll: tn ]
]
