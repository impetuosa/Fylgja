Class {
	#name : #FylgjaAddCatchExceptionPrintStacktrace,
	#superclass : #FylgjaModification,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddCatchExceptionPrintStacktrace class >> possibleWritingMessages [

	^ { #writeCatch: }
]

{ #category : #'as yet unclassified' }
FylgjaAddCatchExceptionPrintStacktrace >> exceptionReferenceUsing: aWriter [

	| candidate |
	candidate := aWriter model allEntitiesSelect: [ :a | 
		             a isType and: [ 
			             a name = #Exception and: [ 
				             a packageReference name = #'java.lang' ] ] ].

	candidate := candidate
		             ifEmpty: [ nil ]
		             ifNotEmpty: [ candidate first ].
	^ (aWriter typeReferenceNamed: #Exception)
		  packageReference: (aWriter packageReferenceNamed: #'java.lang');
		  candidate: candidate;
		  yourself
]

{ #category : #'instance creation' }
FylgjaAddCatchExceptionPrintStacktrace >> privateApplyOn: aTryCatchWriter [

	aTryCatchWriter writeCatch: [ :catch | 
		| errorParameter |
		errorParameter := catch writeParameter: [ :error | 
			                  error
				                  typeReference:
					                  (self exceptionReferenceUsing: error);
				                  name: 'e' ].
		catch writeBlock: [ :b | 
			b writeExpressionStatement: [ :stmt | 
				stmt writeExpression: [ :exp | 
					FylgjaAddMethodInvocation new
						selector: #printStackTrace;
						arguments: #(  );
						receiver: (self variableReferenceTo: errorParameter using: b);
						privateApplyOn: exp ] ] ] ]
]
