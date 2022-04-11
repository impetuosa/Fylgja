Class {
	#name : #FylgjaAddGetter,
	#superclass : #FylgjaProduce,
	#instVars : [
		'attribute'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddGetter >> applyOn: aWriter [

	^ aWriter writeMethod: [ :getter | 
		  getter returnTypeReference: attribute typeReference.
		  getter selector: ('get{1}' format: { attribute name capitalized }).


		  getter writeBlock: [ :block | 
			  FylgjaAddReturn new
				  variable: attribute;
				  applyOn: block ] ]
]

{ #category : #accessing }
FylgjaAddGetter >> attribute: aMOAttribute [ 
	attribute := aMOAttribute
]
