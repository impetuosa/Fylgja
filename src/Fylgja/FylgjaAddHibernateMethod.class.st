Class {
	#name : #FylgjaAddHibernateMethod,
	#superclass : #FylgjaModification,
	#instVars : [
		'modelTypeReference',
		'sessionFactory'
	],
	#category : #'Fylgja-Rule-Operations'
}

{ #category : #'instance creation' }
FylgjaAddHibernateMethod class >> possibleWritingMessages [

	^ { #writeMethod: }
]

{ #category : #accessing }
FylgjaAddHibernateMethod >> modelTypeReference: aMOTypeReference [ 
	modelTypeReference := aMOTypeReference
]

{ #category : #'instance creation' }
FylgjaAddHibernateMethod >> sendToCurrentSession: selector using: parameter into: exp [

	^ FylgjaAddChainMethodInvocation new
		  firstReceiverReference:
			  (self variableReferenceTo: sessionFactory using: exp);
		  addSelector: #getCurrentSession arguments: {  };
		  addSelector: selector
		  arguments: { (self variableReferenceTo: parameter using: exp) };
		  applyOn: exp
]

{ #category : #accessing }
FylgjaAddHibernateMethod >> sessionFactory: aMOAttribute [ 
	sessionFactory := aMOAttribute
]

{ #category : #'instance creation' }
FylgjaAddHibernateMethod >> typeReferenceListOf: aMOTypeReference using: aMOMethodWriter [

	| ref |
	ref := self
		       calculateTypeReference: #List
		       packageName: 'java.util'
		       using: aMOMethodWriter.

	ref argumentTypeReferences: { aMOTypeReference }.

	^ ref
]

{ #category : #'as yet unclassified' }
FylgjaAddHibernateMethod >> typeReferenceQueryOf: aMOTypeReference using: aMOMethodWriter [

	| ref |
	ref := self
		       calculateParametrizableTypeReference: #Query
		       packageName: 'org.hibernate.query'
		       using: aMOMethodWriter.

	ref argumentTypeReferences: { aMOTypeReference }.

	^ ref
]
