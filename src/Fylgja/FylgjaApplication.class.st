Class {
	#name : #FylgjaApplication,
	#superclass : #SpApplication,
	#instVars : [
		'controller'
	],
	#category : #'Fylgja-UI'
}

{ #category : #accessing }
FylgjaApplication class >> egrc [

	^ self new
		  controller: FylgjaMigrationUIController egrcController;
		  yourself
]

{ #category : #accessing }
FylgjaApplication class >> northwind [

	^ self new
		  controller: FylgjaMigrationUIController northwindController;
		  yourself
]

{ #category : #accessing }
FylgjaApplication >> controller [
	^ controller
]

{ #category : #accessing }
FylgjaApplication >> controller: aFylgjaMigrationUIController [ 
	controller := aFylgjaMigrationUIController
]

{ #category : #'as yet unclassified' }
FylgjaApplication >> migratorSingleDestinationUi [
			<doc:
	'Create a single destination UI. (for two models)'>
	^ FylgjaMigratorSingleDestinationUI newApplication: self
]

{ #category : #'as yet unclassified' }
FylgjaApplication >> migratorUi [
	<doc:
	'Create a two destination UI. (for three models)'>
	^ FylgjaMigratorUI newApplication: self
]

{ #category : #'as yet unclassified' }
FylgjaApplication >> openMigrator [

	^ self migratorUi open
]

{ #category : #'as yet unclassified' }
FylgjaApplication >> openMigratorSingleDestination [

	^ self migratorSingleDestinationUi open
]
