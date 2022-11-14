Class {
	#name : #FylgjaFormToAngularService,
	#superclass : #FylgjaFormToAngular,
	#category : #'Fylgja-Rule-Generation'
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

{ #category : #'as yet unclassified' }
FylgjaFormToAngularService >> applyTo: aRelatedProvenanceEntity croppingRelationsWith: aBlock destinationWriter: aDestinationWriter lookUp: aFylgjaLookUpContext using: aFylgjaDerivativeModel [

	| http url cls sources |
	sources := self recogniceDataSourceAccesses:
		           aRelatedProvenanceEntity to.

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
			       sources do: [ :s | 
				       self
					       generateServiceMethodFor: s
					       delegateTo: http
					       url: url
					       into: class
					       using: aFylgjaDerivativeModel ] ].
		(self importableDependencies: cls) do: [ :type | 
			unit writeImport: [ :import | 
				import importingTypeOrTypeReference: type ] ] ].
	^ cls
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngularService >> generateServiceMethodFor: aFylgjaSQLSource delegateTo: http url: url into: aMOTypescriptClassWriter using: aFylgjaDerivativeModel [

	^ aFylgjaSQLSource
		  fylgja: aFylgjaDerivativeModel;
		  applyOnFrontEndService: aMOTypescriptClassWriter delegateTo: http url: url 
]

{ #category : #'as yet unclassified' }
FylgjaFormToAngularService >> generateServiceMethodFor: aFylgjaSQLSource into: aMOTypescriptClassWriter using: aFylgjaDerivativeModel [

	^ aFylgjaSQLSource
		  fylgja: aFylgjaDerivativeModel;
		  applyOnFrontEndService: aMOTypescriptClassWriter
]

{ #category : #adding }
FylgjaFormToAngularService >> printOn: aStream [
 	aStream nextPutAll: 'Produce Angular Component based on Forms usage'
]
