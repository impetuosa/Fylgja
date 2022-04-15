Class {
	#name : #FylgjaAddSetter,
	#superclass : #FylgjaAddAccessor,
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddSetter >> applyOn: aWriter [

	^ aWriter writeMethod: [ :setter | 
		  | parameter |
		  setter returnTypeReference: (setter typeReferenceNamed: #void).
		  setter selector: ('set{1}' format: { attribute name capitalized }).
		  parameter := setter writeParameter: [ :param | 
			               param
				               name:
					               ('a{1}' format:
							                { attribute typeReference name capitalized });
				               typeReference: attribute typeReference ].

		  setter writeBlock: [ :block | 
			  FylgjaAddAssignment new
				  read: (self referenceToVarLike: parameter using: block);
				  write: (self attributeReference: block);
				  applyOn: block ] ]
]