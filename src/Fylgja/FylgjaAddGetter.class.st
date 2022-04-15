Class {
	#name : #FylgjaAddGetter,
	#superclass : #FylgjaAddAccessor,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddGetter >> applyOn: aWriter [

	^ aWriter writeMethod: [ :getter | 
		  getter returnTypeReference: attribute typeReference.
		  getter selector: ('get{1}' format: { attribute name capitalized }).


		  getter writeBlock: [ :block | 
			  FylgjaAddReturn new
				  expression: (self attributeReference: block);
				  applyOn: block ] ]
]