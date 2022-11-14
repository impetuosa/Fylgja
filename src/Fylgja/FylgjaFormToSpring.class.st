Class {
	#name : #FylgjaFormToSpring,
	#superclass : #FylgjaAccessToSpring,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'as yet unclassified' }
FylgjaFormToSpring class >> possibleWritingMessages [

	^ { #writeDeclarationUnit: }
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isWidget and: [ 
		  self canWriteOver: aWriter ]
]

{ #category : #'as yet unclassified' }
FylgjaFormToSpring >> recogniceDataSourceAccesses: aMOAlceForm [

	| ds |
	ds := OrderedCollection new.

	aMOAlceForm object allEndingWith: #Source ifPresentDo: [ :rs | 
		(self looksLikeSql: rs) ifTrue: [ 
			ds add: (FylgjaSQLSource new sql: rs) ] ].
	aMOAlceForm object objectEntries do: [ :obj | 
		obj allEndingWith: #Source ifPresentDo: [ :rs | 
			(self looksLikeSql: rs) ifTrue: [ 
				ds add: (FylgjaSQLSource new
						 sql: rs;
						 bindingObject: obj;
						 yourself) ] ] ].
	^ ds
]
