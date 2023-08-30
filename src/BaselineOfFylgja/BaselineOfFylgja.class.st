Class {
	#name : #BaselineOfFylgja,
	#superclass : #BaselineOf,
	#category : #BaselineOfFylgja
}

{ #category : #baselines }
BaselineOfFylgja >> baseline: spec [

	<baseline>
	spec
		baseline: 'Moxing'
		with: [ spec repository: 'github://impetuosa/Moxing' ].
	"spec
		baseline: 'CasinoGlue'
		with: [ spec repository: 'github://impetuosa/CasinoGlue' ]"
]
