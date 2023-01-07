Class {
	#name : #FylgjaTranslateCopyAsAnnotatedMethod,
	#superclass : #FylgjaTranslateCopyAsMethod,
	#category : #'Fylgja-Rule-Translation'
}

{ #category : #testing }
FylgjaTranslateCopyAsAnnotatedMethod >> annotateAndCreateUrl: parameters withAnyOf: possibleAnnotations [

	| url annotation |
	url := '' writeStream.

	parameters do: [ :sourceParameter | 
		annotation := self chooseFromParameterAnnotation:
			              possibleAnnotations.

		(annotation = #None or: [ annotation isNil ])
			ifTrue: [ 
				FylgjaMigrate new
					lookUp: lookUp;
					fylgja: fylgja;
					provenanceEntity: sourceParameter;
					cropping: cropping;
					applyOn: writer ]
			ifFalse: [ 
				writer writeParameter: [ :param | 
					param name: sourceParameter name.

					param typeReference: (FylgjaMigrate new
							 cropping: cropping;
							 fylgja: fylgja;
							 lookUp: lookUp;
							 provenanceEntity: sourceParameter typeReference;
							 applyOn: param).
					FylgjaAnnotate new
						packageName: 'org.springframework.web.bind.annotation';
						annotationName: annotation;
						addArgument: sourceParameter name;
						applyOn: param.
					annotation = #PathVariable ifTrue: [ 
						url
							nextPutAll: '/{';
							nextPutAll: sourceParameter name;
							nextPutAll: '}' ] ] ] ].
	^ url contents
]

{ #category : #testing }
FylgjaTranslateCopyAsAnnotatedMethod >> applyTo: aProvenanceEntityRelation croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| method |
	method := super
		          applyTo: aProvenanceEntityRelation
		          croppingRelationsWith: aBlock
		          destinationWriter: aDestinationWriter
		          lookUp: aFylgjaLookUpContext
		          using: aFylgjaDerivativeModel.
	
	^ method
]

{ #category : #testing }
FylgjaTranslateCopyAsAnnotatedMethod >> chooseFromParameterAnnotation: possibleAnnotations [

	^ UIManager default
		  chooseFrom: possibleAnnotations
		  values: possibleAnnotations
		  title:
		  'Please choose what kind of annotation you want for the new controller'
]

{ #category : #testing }
FylgjaTranslateCopyAsAnnotatedMethod >> copyFullBody [

	| options chosen method url |
	options := { 
		           (#PostMapping -> { #RequestBody. #PathVariable.
		            #None }).
		           (#GetMapping -> { #PathVariable. #None }).
		           (#DeleteMapping -> { #PathVariable. #None }).
		           (#None -> {  }) }.


	chosen := UIManager default
		          chooseFrom: (options collect: #key)
		          values: options
		          title:
		          'Please choose what kind of annotation you want for the new controller'.

	(chosen isNil or: [ chosen key = #None ]) ifTrue: [ 
		^ super copyFullBody ].

	url := provenance to selector , (self
		        annotateAndCreateUrl: provenance to parameters
		        withAnyOf: chosen value).


	FylgjaAnnotate new
		packageName: 'org.springframework.web.bind.annotation';
		annotationName: chosen key;
		addArgument: url;
		applyOn: writer.

	FylgjaCopy new
		lookUp: lookUp;
		fylgja: fylgja;
		provenanceRelation: provenance;
		cropping: [ :col | 
			(cropping value: col) reject: [ :relation | 
					relation from = provenance to and: [ 
							relation to isKindOf: MOParameter ] ] ];
		applyOn: writer
]

{ #category : #testing }
FylgjaTranslateCopyAsAnnotatedMethod >> printOn: aStream [
 	aStream nextPutAll: 'Transform into Method Controller'
]
