Class {
	#name : #FylgjaAddSetter,
	#superclass : #FylgjaAddAccessor,
	#category : #'Fylgja-Rule-Modifications'
}

{ #category : #'instance creation' }
FylgjaAddSetter >> privateApplyOn: aWriter [

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
				  privateApplyOn: block ] ]
]
