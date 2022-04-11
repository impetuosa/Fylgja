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
SirenMigrationTests >> installRulesFor: aDestination [
  FylgjaRuleInstaller new
     topLevel;
     anyBindableEntity;
     mappingStubInstall;
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
     installInto: fylgja
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

{ #category : #initialization }
SirenMigrationTests >> sirenExternalInterface [
  ^vw entities detect: [:a |  a isType and: [ a name = #SirenExternalInterface ] ]
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
  self assert: (tonel allButFirst allSatisfy: [:a |  a isKindOf: MCMethodDefinition ]).

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
