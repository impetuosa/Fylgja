Class {
	#name : #SirenMigrationTests,
	#superclass : #TestCase,
	#instVars : [
		'fylgja',
		'pharo',
		'vw'
	],
	#category : #'Fylgja-Test-VWPharo'
}

{ #category : #initialization }
SirenMigrationTests >> cPointer [
  ^vw entities detect: [:a |  a isType and: [ a name = #CPointer ] ] 
]

{ #category : #initialization }
SirenMigrationTests >> checkit [

]

{ #category : #'as yet unclassified' }
SirenMigrationTests >> externalAddress [
  ^pharo entities detect: [:a |  (a isKindOf: MOStClass) and: [ a name = #ExternalAddress ] ]
]

{ #category : #initialization }
SirenMigrationTests >> installRulesFor: s [
  FylgjaRuleInstaller new
     topLevel;
     anyBindableEntity;
     mappingLinkedStubInstall;
     installInto: fylgja.

  FylgjaRuleInstaller new
     topLevel;
     anyReferenceWithCandidate;
     returnSameBinding;
     installInto: fylgja.

  FylgjaRuleInstaller new
     topLevel;
     anyEntity;
     copy;
     installInto: fylgja.

  FylgjaRuleInstaller new
     atLanguageNamed: #phiren;
     anyPragmaWithSelector: #C:;
     copyAsSelfFFiInvocation;
     installInto: fylgja.


FylgjaRuleInstaller new
     atLanguageNamed: #phiren;
	  anyReturnInvocationTo: #externalAccessFailedWith:;
     comment;
     installInto: fylgja.


  FylgjaRuleInstaller new
     atLanguageNamed: #phiren;
     referenceNamed: #ExternalInterface;
     copyAsTypesReferenceNamed: #FFILibrary;
     installInto: fylgja.

  FylgjaRuleInstaller new
     atLanguageNamed: #phiren;
     anyEntityOfType: MOStExensionMethodDeclarationUnit;
     copyRecategorizeMethods;
     installInto: fylgja.

 FylgjaRuleInstaller new
     atLanguageNamed: #phiren;
     anyMetaclassMethodNamed: #properties ;
     copyRenameMethod: #props;
     installInto: fylgja.
	
	
 FylgjaRuleInstaller new
     atLanguageNamed: #phiren;
     anyClassNamed: {#Duration . #'Duration class'}; 
     copyRename: #SirenDuration;
     installInto: fylgja.
	

 FylgjaRuleInstaller new
     atLanguageNamed: #phiren;
     anyMethodNamed: {#atRandom: . #atRandom};
     copyRenameMethod: { #atRandom:-> #randomValue: . #atRandom -> #randomValue} ;
     installInto: fylgja.



  fylgja := fylgja map: self cPointer to: self externalAddress.
  fylgja := fylgja map: self vwColorValue to: self phColor.
  fylgja := fylgja map: self vwFilename to: self phFileReference
]

{ #category : #'as yet unclassified' }
SirenMigrationTests >> phColor [
  ^pharo entities detect: [:a |  (a isKindOf: MOStClass) and: [ a name = #Color ] ]
]

{ #category : #'as yet unclassified' }
SirenMigrationTests >> phFileReference [
  ^pharo entities detect: [:a |  (a isKindOf: MOStClass) and: [ a name = #FileReference ] ]
]

{ #category : #'as yet unclassified' }
SirenMigrationTests >> pharoSequenciableCollection [
  ^pharo entities detect: [:a |  a isType and: [ a name = #SequenceableCollection ] ]
]

{ #category : #initialization }
SirenMigrationTests >> pharoSirenPackage [
  ^pharo entities detect: [:a |  (a isKindOf: MOPackage) and: [ a name = #Siren ] ]
]

{ #category : #initialization }
SirenMigrationTests >> portMidiInterface [
  ^vw entities detect: [:a |  a isType and: [ a name = #PortMidiInterface ] ]
]

{ #category : #initialization }
SirenMigrationTests >> runCaseManaged [ 
	^ self runCase 
]

{ #category : #initialization }
SirenMigrationTests >> setUp [
  super setUp.
  fylgja := FylgjaMigrationEngine new.
  vw := MOVisualWorksChunkImporter siren.
  pharo := MORBPharoImporter siren.
  fylgja
     addModel: vw;
     addModel: pharo
]

{ #category : #'as yet unclassified' }
SirenMigrationTests >> sirenAssociation [

  ^vw entities detect: [:a |  a isMethodExtension and: [ a name = #Association ] ]
]

{ #category : #initialization }
SirenMigrationTests >> sirenClasses [
  ^vw entities select: [:a | (( a isKindOf: MOStClass ) and: [ a isPreexisting not ]) or: [ a isMethodExtension  ] ]
]

{ #category : #initialization }
SirenMigrationTests >> sirenExternalInterface [
  ^vw entities detect: [:a |  a isType and: [ a name = #SirenExternalInterface ] ]
]

{ #category : #'as yet unclassified' }
SirenMigrationTests >> sirenFilename [
  ^vw entities detect: [:a |  a isType and: [ a name = #Filename ] ]
]

{ #category : #initialization }
SirenMigrationTests >> sirenFilenameExtensions [
  ^vw entities detect: [:a |  a isMethodExtension  and: [ a name = #Filename ] ] 
]

{ #category : #initialization }
SirenMigrationTests >> sirenZetapoint [
  ^vw entities detect: [:a |  a isType and: [ a name = #ZPoint ] ]
]

{ #category : #initialization }
SirenMigrationTests >> testExportMoveAllClassesToPhSiren [

	| destination provenance result out fn className packageName |
	destination := self pharoSirenPackage.
	provenance := self sirenClasses.
	result := fylgja.
	self installRulesFor: destination.
	out := #Siren asFileReference / #src.
	provenance do: [ :prov | 
		result := result produce: prov into: destination.
		prov packageReferenceName = #Siren
			ifFalse: [ 
				result realResult packageReference name:
					result realResult packageReference name , '-'
					, prov packageReferenceName ]
			ifTrue: [ 
				result realResult packageReference name:
					result realResult packageReference name , '-'
					, result realResult category ].
		result realResult category: result realResult packageReference name.

		className := result realResult name.
		packageName := result realResult packageReference name.

		result realResult isMethodExtension
			ifTrue: [ 
				result realResult extensionMethods do: [ :em | 
					em category: '*' , packageName ].
				fn := className , '.extension.st' ]
			ifFalse: [ fn := className , '.class.st' ].
		(out / packageName) exists ifFalse: [ 
			(out / packageName) ensureCreateDirectory.
			(out / packageName / 'package.st') writeStream
				nextPutAll: 'Package{ #name : #';
				nextPutAll: packageName;
				nextPutAll: '}';
				newLine;
				flush;
				close ].
		(out / packageName / fn) ensureDelete.
		(out / packageName / fn) writeStream
			nextPutAll: result realResult produceCode;
			flush;
			close.
		self checkit ]
]

{ #category : #initialization }
SirenMigrationTests >> testFilenameToPhiren [

	| destination provenance result tonel |
	destination := self pharoSirenPackage.
	provenance := self sirenFilenameExtensions.
	self installRulesFor: destination.
	result := fylgja produce: provenance into: destination.
	result forceMap.
	tonel := TonelParser parseString: result result produceCode.
	self assert: tonel size equals: 3.
	self assert: result result name equals: #FileReference.
	self assert: result result classReference name equals: #FileReference.
	self assert:
		(tonel allSatisfy: [ :a | a isKindOf: MCMethodDefinition ])
]

{ #category : #initialization }
SirenMigrationTests >> testMoveAllClassesToPhSiren [

	| destination provenance result tonels results codes errors |
	destination := self pharoSirenPackage.
	provenance := self sirenClasses.

	result := fylgja.
	self installRulesFor: destination.
	results := provenance collect: [ :prov | 
		           result := result produce: prov into: destination ].

	codes := results collect: [ :e | e realResult produceCode ].
	tonels := codes collect: [ :cod | 
		          cod -> ([ TonelParser parseString: cod ]
			           on: Error
			           do: [ :e | e ]) ].
	errors := tonels select: [ :a | a value isError ].
	self assert: errors isEmpty
]

{ #category : #initialization }
SirenMigrationTests >> testMoveAssociationToPhiren [

	| destination provenance result tonel |
	destination := self pharoSirenPackage.
	provenance := self sirenAssociation.

	self installRulesFor: destination.
	result := fylgja produce: provenance into: destination.
	tonel := TonelParser parseString: result result produceCode.
	self assert: tonel size equals: 2.
	self assert: result result name equals: #Association.
	self assert: result result classReference name equals: #Association.
	self assert:
		(tonel allSatisfy: [ :a | a isKindOf: MCMethodDefinition ])
]

{ #category : #initialization }
SirenMigrationTests >> testMovePortMidiInterfaceToPhSiren [

	| destination provenance result tonel |
	destination := self pharoSirenPackage.
	provenance := self portMidiInterface.
	self installRulesFor: destination.
	result := fylgja produce: provenance into: destination.

	tonel := TonelParser parseString: result result produceCode.

	self assert: tonel size equals: 26.
	self assert: (tonel first isKindOf: MCClassDefinition).
	self assert:
		(tonel allButFirst allSatisfy: [ :a | 
			 a isKindOf: MCMethodDefinition ])
]

{ #category : #initialization }
SirenMigrationTests >> testMoveSirenDurationToPhSiren [

	| destination provenance result tonel |
	destination := self pharoSirenPackage.
	provenance := self vwDurationClass.
	self installRulesFor: destination.
	result := fylgja produce: provenance into: destination.

	self assert: result realResult name equals: #SirenDuration.
	self
		assert: result realResult metaclass name
		equals: #'SirenDuration'.
	tonel := TonelParser parseString: result result produceCode.
	self assert: tonel size equals: 10.

	self assert: (tonel first isKindOf: MCClassDefinition).
	self assert:
		(tonel allButFirst allSatisfy: [ :a | 
			 a isKindOf: MCMethodDefinition ])
]

{ #category : #initialization }
SirenMigrationTests >> testMoveSirenExternalInterfaceToPhSiren [
  | destination provenance result tonel |
  destination := self pharoSirenPackage.
  provenance := self sirenExternalInterface.
  self installRulesFor: destination.
  result := fylgja produce: provenance into: destination.
  tonel := TonelParser parseString: result result produceCode.
  self assert: tonel size equals: 6.
  self assert: (tonel first isKindOf: MCClassDefinition).
  self assert: (tonel allButFirst allSatisfy: [:a |  a isKindOf: MCMethodDefinition ]).

]

{ #category : #initialization }
SirenMigrationTests >> testMoveSirenZpointToPhSiren [
  | destination provenance result tonel |
  destination := self pharoSirenPackage.
  provenance := self sirenZetapoint.
  self installRulesFor: destination.
  result := fylgja produce: provenance into: destination.
  tonel := TonelParser parseString: result result produceCode.
  self assert: tonel size equals: 18.

  self assert: (tonel first isKindOf: MCClassDefinition).
  self assert: (tonel allButFirst allSatisfy: [:a |  a isKindOf: MCMethodDefinition ]).

]

{ #category : #'as yet unclassified' }
SirenMigrationTests >> vwColorValue [
  ^vw entities detect: [:a |  a isType and: [ a name = #ColorValue ] ]
]

{ #category : #'as yet unclassified' }
SirenMigrationTests >> vwDurationClass [
  ^vw entities detect: [:a |  a isType and: [ a name = #Duration ] ]
]

{ #category : #initialization }
SirenMigrationTests >> vwFilename [
  ^vw entities detect: [:a |  a isType and: [ a name = #Filename ] ] 
]
