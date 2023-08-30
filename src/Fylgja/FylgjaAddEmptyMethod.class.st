Class {
	#name : #FylgjaAddEmptyMethod,
	#superclass : #FylgjaAddMethod,
	#category : #'Fylgja-Rule-Transformations'
}

{ #category : #'instance creation' }
FylgjaAddEmptyMethod >> privateApplyOn: aMOClassWriter [

	| rp |
	^ aMOClassWriter writeMethod: [ :method | 
		  method selector: selector.
		  method returnTypeReference: returnTypeReference.
		  rp := self parameters collect: [ :kv | 
			        method writeParameter: [ :param | 
				        param
					        name: kv key;
					        typeReference: kv value ] ] ]
]
