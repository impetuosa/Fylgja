"
Given mapping configuration I creates the proper objects and install them in a given context.
"
Class {
	#name : #FylgjaMappingInstaller,
	#superclass : #FylgjaMRSInstaller,
	#instVars : [
		'source',
		'target',
		'mapping'
	],
	#category : #'Fylgja-Mappings'
}

{ #category : #'as yet unclassified' }
FylgjaMappingInstaller >> buildMapping [

	mapping isCollection ifFalse: [ 
		mapping
			source: source;
			target: target.
		^ mapping ].
	^ mapping
		  ifEmpty: [ 
			  FylgjaSimpleMapping new
				  source: source;
				  target: target;
				  yourself ]
		  ifNotEmpty: [ 
			  FylgjaNestedMapping new
				  source: source;
				  target: target;
				  mappings: mapping;
				  yourself ]
]

{ #category : #installation }
FylgjaMappingInstaller >> installInto: aFylgjaDerivativeModel [

	<doc: 'Build and install mapping into a given Fylgja model'>
	| space bm |
	space := self installingSpace: aFylgjaDerivativeModel.
	bm := self buildMapping.
	space installMapping: bm.
	^ bm
]

{ #category : #'as yet unclassified' }
FylgjaMappingInstaller >> map: aProvenanceEntity with: aDestinationEntity using: aMappingCollection [

	<doc: 'Configure the entities to be mapped. Source, Target, Parameter mappings '>
	source := aProvenanceEntity.
	target := aDestinationEntity.
	mapping := aMappingCollection
]
