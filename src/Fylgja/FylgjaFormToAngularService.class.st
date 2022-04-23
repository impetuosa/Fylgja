Class {
	#name : #FylgjaFormToAngularService,
	#superclass : #FylgjaFormToAngular,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #adding }
FylgjaFormToAngularService >> addGetAllMethodService: class for: aMOAlceForm delegateTo: httpClient url: url [

	"
  getStudentList(): Observable<any> {  
    return this.http.get(`${this.baseUrl}`+'students-list');  
  }  
  "

	" ((self calculateParametrizableTypeReference: 'Observable' packageName: 'rxjs' using: class) )"

	^ class writeMethod: [ :method | 
		  method selector: #getAll , aMOAlceForm name.
		  method returnTypeReference: (self
				   calculateReferenceToAnObservable:
				   (self modelNameFor: aMOAlceForm)
				   using: class).
		  method writeBlock: [ :block | 
			  block writeReturn: [ :return | 
				  return writeExpression: [ :exp | 
					  exp
						  invokeMethodNamed: #get
						  receiver: [ :e | 
						  self variableReferenceTo: httpClient using: e ]
						  arguments: [ :argExp | 
							  { (argExp
								   operate: [ :o | self variableReferenceTo: url using: o ]
								   operator: #+
								   with: [ :o | 
								   o stringLiteral: (self modelNameFor: aMOAlceForm) , '-list' ]) } ] ] ] ] ]
]

{ #category : #adding }
FylgjaFormToAngularService >> addSaveModelMethodService: class for: aMOAlceForm delegateTo: httpClient url: url [ 

self halt.
	"^ FylgjaAddDelegateAndTransmitParametersMethod new
		  attributeReference:
			  (self variableReferenceTo: aMOAttribute using: class);
		  returnTypeReference: (self booleanTypeReference: class);
		  selector: #save , (self modelNameFor: aMOAlceForm);
		  parameters: { (#model
			   -> (class typeReferenceNamed: (self modelNameFor: aMOAlceForm))) };
		  applyOn: class"
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngularService >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| http url cls |
	self assert:
		(self
			 hasId: aRelatedProvenanceEntity to
			 using: aFylgjaDerivativeModel) not.
	aDestinationWriter writeDeclarationUnit: [ :unit | 
		cls := unit writeTypescriptClass: [ :class | 
			       class visibility: #public.
			       class addModifier: #export.
			       class name:
				       (self serviceNameFor: aRelatedProvenanceEntity to).


			       self decorateAsInjectableIn: #root into: class.


			       http := self addHttpClientVariable: class.
			       url := self addBaseUrlVariable: class.
			       self addConstructor: class initializing: http.
			       self
				       addGetAllMethodService: class
				       for: aRelatedProvenanceEntity to
				       delegateTo: http
				       url: url.
			       (self
				        hasId: aRelatedProvenanceEntity to
				        using: aFylgjaDerivativeModel) ifTrue: [ 
				       self
					       addSaveModelMethodService: class
					       for: aRelatedProvenanceEntity to
					       delegateTo: http
					       url: url.

				       self
					       addDeleteModelMethodService: class
					       for: aRelatedProvenanceEntity to
					       delegateTo: http
					       url: url.
				       self
					       updateModelMethodService: class
					       for: aRelatedProvenanceEntity to
					       delegateTo: http
					       url: url ] ].
		(self importableDependencies: cls) do: [ :type | 
			unit writeImport: [ :import | 
				import importingTypeOrTypeReference: type ] ] ].
	^ cls
]
