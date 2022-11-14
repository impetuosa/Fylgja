Class {
	#name : #FylgjaMappingInstaller,
	#superclass : #FylgjaMRSInstaller,
	#instVars : [
		'source',
		'target',
		'mapping'
	],
	#category : #'Fylgja-Rules'
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

	| space bm |
	space := self installingSpace: aFylgjaDerivativeModel.
	bm := self buildMapping.
	space installMapping: bm.
	^ bm
]

{ #category : #'as yet unclassified' }
FylgjaMappingInstaller >> map: aProvenanceEntity with: aDestinationEntity using: aMappingCollection [

	source := aProvenanceEntity.
	target := aDestinationEntity.
	mapping := aMappingCollection
]
