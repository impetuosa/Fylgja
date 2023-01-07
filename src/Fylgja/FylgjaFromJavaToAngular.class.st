Class {
	#name : #FylgjaFromJavaToAngular,
	#superclass : #FylgjaGeneration,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'as yet unclassified' }
FylgjaFromJavaToAngular >> communicationMethodWriterFor: aMOAnnotationInstance [

	| methodName literal |
	methodName := aMOAnnotationInstance typeReference name
		              copyReplaceAll: 'Mapping'
		              with: ''.
	methodName := ('instantiate{1}MethodWriter:' format: { methodName })
		              asSymbol.

	literal := (aMOAnnotationInstance arguments first isNamedArgument
		            ifTrue: [ 
		            aMOAnnotationInstance arguments first argumentExpression ]
		            ifFalse: [ aMOAnnotationInstance arguments first ])
		           literal.
	^ self perform: methodName withArguments: { literal }
]

{ #category : #'as yet unclassified' }
FylgjaFromJavaToAngular >> mappingAnnotation: aMOMethod [

	| annotations |
	annotations := aMOMethod annotationInstances select: [ :a | 
		               a typeReference name includesSubstring: 'Mapping' ].
	self assert: annotations size = 1.
	^ annotations first
]
