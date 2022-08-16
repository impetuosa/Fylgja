Class {
	#name : #FylgjaFormToAngular,
	#superclass : #FylgjaAccessToAngular,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'as yet unclassified' }
FylgjaFormToAngular class >> possibleWritingMessages [

	^ { #writeDeclarationUnit: }
]

{ #category : #adding }
FylgjaFormToAngular >> addBaseUrlVariable: class [

	^ FylgjaAddAttribute new
		  name: #baseUrl;
		  typeReference:
			  (self calculateTypeReference: 'string' using: class);
		  initializer: (class stringLiteral: 'http://localhost:8080/api/');
		  applyOn: class
]

{ #category : #adding }
FylgjaFormToAngular >> addConstructor: class initializing: aMOAttribute [

	^ FylgjaAddAttributeInitializingConstructor new
		  attributes: { aMOAttribute };
		  applyOn: class
]

{ #category : #adding }
FylgjaFormToAngular >> addHttpClientVariable: class [

	^ FylgjaAddAttribute new
		  name: #http;
		  typeReference: (self
				   calculateTypeReference: 'HttpClient'
				   packageName: '@angular/common/http'
				   using: class);
		  applyOn: class
]

{ #category : #testing }
FylgjaFormToAngular >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [

	^ aProvenanceEntityRelation to isWidget and: [ 
		  self canWriteOver: aWriter ]
]

{ #category : #testing }
FylgjaFormToAngular >> isValueHoldingTypeReference: aMOTypeReference [

	self halt: aMOTypeReference name.
	^ { #_Combobox . #_Label } includes: aMOTypeReference name
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> recogniceDataSourceAccesses: aMOAlceForm [

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

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> resolveModelClassReferenceFor: aRelatedProvenanceEntity using: writer [

	^ self
		  calculateTypeReference:
		  (self modelNameFor: aRelatedProvenanceEntity to)
		  using: writer
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> resolveServiceClassReferenceFor: aRelatedProvenanceEntity using: writer [

	^ self
		  calculateTypeReference:
		  (self serviceNameFor: aRelatedProvenanceEntity to)
		  using: writer
]
