Class {
	#name : #FylgjaFormToAngular,
	#superclass : #FylgjaGeneration,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> allDataBoundableAttributes: object model: model [

	| tableName |
	tableName := object state at: #RecordSource.
	self assert:
		(tableName includesSubstring: #select caseSensitive: false) not.
	^ (model entities select: [ :a | 
		   ((a isKindOf: MOAlceTable) or: [ a isKindOf: MOAlceQuery ]) and: [ 
			   a compareName: tableName ] ]) flatCollect: #attributes
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> collectAllDatabaseBindings: aMOObject marringWith: dbAttrs [

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
FylgjaFormToAngular >> databaseSourceName: object [

	^ object state at: #RecordSource
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> modelNameFor: aFormOrReport [

	^ (self saniteName: aFormOrReport) , '_Model'
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> resolveModelClassReferenceFor: aRelatedProvenanceEntity using: writer [

	^ self
		  calculateTypeReference:
		  (self modelNameFor: aRelatedProvenanceEntity to name)
		  using: writer
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> resolveServiceClassReferenceFor: aRelatedProvenanceEntity using: writer [

	^ self
		  calculateTypeReference:
		  (self serviceNameFor: aRelatedProvenanceEntity to name)
		  using: writer
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> saniteName: aFormOrReport [

	^ (aFormOrReport name copyReplaceAll: 'Form_' with: '')
		  copyReplaceAll: 'Report_'
		  with: ''
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngular >> serviceNameFor: aFormOrReport [

	^ (self saniteName: aFormOrReport) , '_Service'
]
