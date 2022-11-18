Class {
	#name : #FylgjaFromJavaControllerToAngularService,
	#superclass : #FylgjaFromJavaToAngular,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'as yet unclassified' }
FylgjaFromJavaControllerToAngularService >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| annotation parameters communicationMethodWriter |
	annotation := self mappingAnnotation: aRelatedProvenanceEntity to.

	communicationMethodWriter := self communicationMethodWriterFor:
		                             annotation.
	communicationMethodWriter http:
		(aDestinationWriter attributes detect: [ :a | 
			 a typeReference name = #HttpClient ]).
	communicationMethodWriter baseUrl:
		(aDestinationWriter attributes detect: [ :a | a name = #baseUrl ]).

	parameters := self
		              getParameters: aRelatedProvenanceEntity
		              boundedBy: annotation.

	^ aDestinationWriter writeMethod: [ :method | 
		  method visibility: #public.
		  method selector: aRelatedProvenanceEntity to selector.
		  parameters do: [ :p | 
			  FylgjaMigrate new
				  cropping: aBlock;
				  fylgja: aFylgjaDerivativeModel;
				  lookUp: aFylgjaLookUpContext;
				  provenanceEntity: p;
				  applyOn: method ].
		  method returnTypeReference: (FylgjaMigrate new
				   cropping: aBlock;
				   fylgja: aFylgjaDerivativeModel;
				   lookUp: aFylgjaLookUpContext;
				   provenanceEntity:
					   aRelatedProvenanceEntity to returnTypeReference;
				   applyOn: method).
		  method writeBlock: [ :block | 
			  communicationMethodWriter
				  parameters: parameters;
				  applyOn: block ] ]
]

{ #category : #'as yet unclassified' }
FylgjaFromJavaControllerToAngularService >> canBeAppliedTo: aProvenanceEntityRelation context: aDestinationContextRelation forProducing: aType with: aWriter [


	^ aProvenanceEntityRelation to parent isNotNil and: [ 
		  aProvenanceEntityRelation to parent isClassLike and: [ 
			  (aProvenanceEntityRelation to parent annotationInstances 
				   anySatisfy: [ :annotation | 
					   #( RestController RequestMapping ) includes:
						   annotation typeReference name ]) and: [ 
				  aProvenanceEntityRelation to isInvocable and: [ 
					  aProvenanceEntityRelation to annotationInstances anySatisfy: [ 
						  :annotation | 
						  #( PostMapping DeleteMapping GetMapping RequestMapping ) 
							  includes: annotation typeReference name ] ] ] ] ]
]

{ #category : #'as yet unclassified' }
FylgjaFromJavaControllerToAngularService >> getParameters: aMONullDeclarationRelation boundedBy: aMOAnnotationInstance [

	| endpoint parameters |
	parameters := aMONullDeclarationRelation to parameters.

	endpoint := aMOAnnotationInstance arguments first argumentExpression
		            literal.
	^ ('/' split: endpoint)
		  select: [ :e | e beginsWith: '{' ]
		  thenCollect: [ :e | 
			  parameters detect: [ :p | 
				  p name asLowercase = (e copyFrom: 2 to: e size - 1) asLowercase ] ]
]

{ #category : #'as yet unclassified' }
FylgjaFromJavaControllerToAngularService >> instantiateGetMethodWriter: aString [

	^ FylgjaAngularGetHttpCallWriter new
		  endpoint: aString;
		  yourself
]

{ #category : #'as yet unclassified' }
FylgjaFromJavaControllerToAngularService >> instantiateRequestMethodWriter: aString [

	^ self instantiateGetMethodWriter: aString
]
