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
SirenMigrationTests >> installRulesFor: s [
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
     installInto: fylgja.

  FylgjaRuleInstaller new
     atLanguageNamed: #phiren;
     anyPragmaWithSelector:#C:;
     copyAsSelfFFiInvocation;
     installInto: fylgja.


 FylgjaRuleInstaller new
     atLanguageNamed: #phiren;
     anyPreexistingClass;
     copyOrExtendClass;
     installInto: fylgja.

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
SirenMigrationTests >> sirenClasses [
  ^vw entities select: [:a |  a isKindOf: MOStClass ]
]

{ #category : #initialization }
SirenMigrationTests >> sirenExternalInterface [
  ^vw entities detect: [:a |  a isType and: [ a name = #SirenExternalInterface ] ]
]

{ #category : #initialization }
SirenMigrationTests >> testMoveAllClassesToPhSiren [
  | destination provenance result tonels results codes errors |
  destination := self pharoSirenPackage.
  provenance := self sirenClasses.

	result := fylgja.
  self installRulesFor: destination.
results:=provenance collect: [ : prov|  
  result := result produce: prov into: destination.
] .
	
  codes := results collect: [ :e | e produceResultsCode ]. 
  tonels := codes collect: [ : cod|cod ->([ TonelParser parseString:cod] on:Error do: [:e | e ] ) ].
errors := tonels select: [ :a | a value isError ].
self assert: errors isEmpty 
]

{ #category : #initialization }
SirenMigrationTests >> testMovePortMidiInterfaceToPhSiren [
  | destination provenance result tonel |
  destination := self pharoSirenPackage.
  provenance := self portMidiInterface.
  self installRulesFor: destination.
  result := fylgja produce: provenance into: destination.
  result result produceCode inspect. 
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
