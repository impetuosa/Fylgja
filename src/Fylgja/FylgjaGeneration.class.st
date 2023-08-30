"
Generation operations are those operations which generate large pieces of code based on certain description or source entity. 
 This kind of rules are often strict for source and target technology. 
 For example, how to create a hibernate/spring DAO class, a controller, a model or a service based on analyzing the configuration of a Microsoft Access form.
 



"
Class {
	#name : #FylgjaGeneration,
	#superclass : #FylgjaProduction,
	#category : #'Fylgja-Rule-Generation'
}

{ #category : #'as yet unclassified' }
FylgjaGeneration class >> holdsPackageDocumentation [

	^ self = FylgjaGeneration
]
