Class {
	#name : #FylgjaFromJavaToAngular,
	#superclass : #FylgjaGeneration,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'as yet unclassified' }
FylgjaFromJavaToAngular >> communicationMethodWriterFor: aMOAnnotationInstance [

	| methodName |
	methodName := aMOAnnotationInstance typeReference name
		              copyReplaceAll: 'Mapping'
		              with: ''.
	methodName := ('instantiate{1}MethodWriter:' format: { methodName })
		              asSymbol.


	^ self
		  perform: methodName
		  withArguments:
		  { aMOAnnotationInstance arguments first argumentExpression literal }
]

{ #category : #'as yet unclassified' }
FylgjaFromJavaToAngular >> mappingAnnotation: aMOMethod [

	| annotations |
	annotations := aMOMethod annotationInstances select: [ :a | 
		               a typeReference name includesSubstring: 'Mapping' ].
	self assert: annotations size = 1.
	^ annotations first
]
