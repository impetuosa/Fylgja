Class {
	#name : #FylgjaChooseRuleStrategy,
	#superclass : #Object,
	#category : #'Fylgja-MRS'
}

{ #category : #accessing }
FylgjaChooseRuleStrategy class >> default [

	^ FylgjaAutomaticChooseRuleStrategy new
]

{ #category : #'as yet unclassified' }
FylgjaChooseRuleStrategy >> filterOneRulePerMaxPriorityPerSource: aCollection [

	| groupedBySource max |
	groupedBySource := aCollection groupedBy: #key.
	groupedBySource := (groupedBySource associations collect: [ :assoc | 
		                    assoc value value size = 1
			                    ifTrue: [ assoc value value ]
			                    ifFalse: [ 
				                    max := assoc value value max: [ :r | 
					                           r value priority ].
				                    assoc value value select: [ :r | 
					                    r value priority = max ] ] ]) flatCollect:
		                   #yourself.
	"Ensure no repetitions"
	[ groupedBySource asDictionary values ]
		on: Error
		do: [ 
			self error:
				'Rule selection collision: More than one rule applies on the same map space for the given entity! ' ].
	^ groupedBySource collect: #value
]
