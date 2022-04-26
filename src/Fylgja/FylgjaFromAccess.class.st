Class {
	#name : #FylgjaFromAccess,
	#superclass : #FylgjaGeneration,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> allDataBoundableAttributes: object model: model [

	| tableName |
	tableName := object state at: #RecordSource.
	self assert:
		(tableName includesSubstring: #select caseSensitive: false) not.
	^ (model entities select: [ :a | 
		   ((a isKindOf: MOAlceTable) or: [ a isKindOf: MOAlceQuery ]) and: [ 
			   a compareName: tableName ] ]) flatCollect: #attributes
]

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> collectAllDatabaseBindings: aMOObject marringWith: dbAttrs [

	^ (aMOObject state values
		   select: [ :val | 
			   (val isKindOf: MOObject) and: [ 
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
	self assert: aMOAlceForm methods isEmpty.

	model := aFylgjaDerivativeModel selectDerivativeModelFor: aMOAlceForm.
	object := self defaultInstanceFor: aMOAlceForm withIn: model.

	tableName := self databaseSourceName: object.

	table := (model allEntitiesSelect: [ :a | 
		         a isDatasource and: [ 
			         a name = tableName or: [ 
				         a sanitizedName = (a sanitize: tableName) ] ] ]) first.


	^ table hasIdColumns
]

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> modelNameFor: aFormOrReport [

	^ (self sanitizeName: aFormOrReport) , '_Model'
]

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> sanitizeName: aFormOrReport [

	^ (aFormOrReport name copyReplaceAll: 'Form_' with: '')
		  copyReplaceAll: 'Report_'
		  with: ''
]

{ #category : #'as yet unclassified' }
FylgjaFromAccess >> serviceNameFor: aFormOrReport [

	^ (self sanitizeName: aFormOrReport) , '_Service'
]
