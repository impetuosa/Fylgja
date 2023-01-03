Class {
	#name : #FylgjaFromAccess,
	#superclass : #FylgjaGeneration,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> allDataBoundableAttributes: object model: model [

	| tableName |
	tableName := object state at: #RecordSource.
	self assert:
		(tableName includesSubstring: #select caseSensitive: false) not.
	^ (self tablesRespondingTo: tableName within: model) flatCollect:
		  #attributes
]

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> collectAllDatabaseBindings: aMOObject marringWith: dbAttrs [

	^ (aMOObject state values
		   select: [ :val | 
			   (val isKindOf: MOObjectInstance) and: [ 
				   (val state includesKey: #ControlSource) and: [ 
					   (val state at: #ControlSource) isNotEmpty and: [ 
						   (val state at: #ControlSource) first ~= $= ] ] ] ]
		   thenCollect: [ :val | 
			   val -> (dbAttrs detect: [ :db | 
				    db compareName: (val state at: #ControlSource) ]) ])
		  asDictionary
]

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> databaseSourceName: object [

	^ object state at: #RecordSource
]

{ #category : #testing }
FylgjaFromAccess >> hasId: aMOAlceForm using: aFylgjaDerivativeModel [

	| model object tableName table |
	model := aFylgjaDerivativeModel selectDerivativeModelFor: aMOAlceForm.
	object := self defaultInstanceFor: aMOAlceForm withIn: model.

	tableName := self databaseSourceName: object.
	tableName ifEmpty: [ ^ false ].
	table := (self tablesRespondingTo: tableName within: model) first.


	^ table hasIdColumns
]

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> looksLikeSql: aString [

	^ [ 
	  aString isNotEmpty and: [ 
		  PostgreSQLParser parseSelectQuery: aString toPG.
		  true ] ]
		  on: Error
		  do: [ ^ false ]
]

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> modelNameFor: aFormOrReport [

	^ (self sanitizeName: aFormOrReport) , '_Model'
]

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> modelNameForString: aString [

	^ (MOObject sanitize: aString) , '_Model'
]

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> sanitizeName: aFormOrReport [

	^ (aFormOrReport sanitizedName copyReplaceAll: 'Form_' with: '')
		  copyReplaceAll: 'Report_'
		  with: ''
]

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> serviceNameFor: aFormOrReport [

	^ (self sanitizeName: aFormOrReport) , '_Service'
]

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> serviceNameForString: aString [

	^ (MOObject sanitize: aString) , '_Service'
]

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> tablesRespondingTo: aName within: aModel [

	^ aModel allEntitiesSelect: [ :a | 
		  ((a isKindOf: MOAlceTable) or: [ a isKindOf: MOAlceQuery ]) and: [ 
			  a compareName: aName ] ]
]
