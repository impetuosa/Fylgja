Class {
	#name : #FylgjaIsMethodNamedInMetaclass,
	#superclass : #FylgjaCondition,
	#instVars : [
		'names'
	],
	#category : #'Fylgja-Test-VWPharo'
}

{ #category : #accessing }
FylgjaIsMethodNamedInMetaclass >> matches: aProvenanceEntityRelation context: aDestinationContextRelation forWriting: aType with: aWriter [
  ^ aProvenanceEntityRelation from class = MOMetaClass and: [ 
	aProvenanceEntityRelation to class = MOStMethod and: 
	[ names includes: aProvenanceEntityRelation to selector ] ]
]

{ #category : #accessing }
FylgjaIsMethodNamedInMetaclass >> names: aCollection [ 
	names := aCollection
]
