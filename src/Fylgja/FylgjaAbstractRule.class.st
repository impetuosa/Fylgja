"
#Rules
Rules are scoped conditional operations consisting of a Condition and an Oper- ation. Condition consists of a predicate that ensures the satisfaction of the operation’s assumptions and requirements. Operation consists of any system- atic modification over the target. By scoped, we mean that they have a scope of validity. This scope is all migration models, as there are default rules, a spe- cific project, package, class, or method. This context is defined when installing the rules. We have two families or rules: Productive and Adaptive.


#Productive

These rules create a migrated version of a source entity in the context of a target entity, that is to say, as a child of this target entity. Applying a Productive Rule also entails automatically mapping the source entity and the produced target entity.
* Condition consists of a predicate that tells if the rule can produce this migrated version within the specific target entity.
* Operation consists of modifying the target entity by defining the source entity’s migrated version. These rules are typically applied from the legacy application model containing the source entity to a migrated application model containing the target entity.
For example, a rule that is executed when the source entity is a function and the target context is a class, and it operates a migration by defining a method in the target class based on the source function.




#Adaptive 
We said before that references to a software artefact must be replaced as ref- erences to another equivalent software artefact. To enable this replacement mechanism, we copy the references as they are, knowing that this may be a wrong decision, and delay the migration criteria to when this other soft- ware artefact is available. Adaptive rules detect the apparition of semantically equivalent declarations and modify or replace reference objects based on the nature of the software artefact.
* Condition consists of a predicate that tells if the rule can modify or replace a target reference to refer to a given target declaration.
* Operation consists of the adaptation of the reference object.
For example, let us consider a function that just migrated as a static method. Right after, an adaptive rule will detect that this static method is recognised as equivalent to the function and therefore detect all the uses (migrated before and after the migration of the function) and adapt them from the form function() to the form ClassName.function().



#Implementation

In the implementation we hold two kind of rules: Static and Dynamic. 

Static rules define condition and operation as methods.
Dynamic rules define condition and operation as strategies. 

Static rules are easier to read, however, the condition and transformations to be applied become impossible to reuse. 
Dynamic rules are harder to read and to construct. 


#Kind of rules 

We split the productive rules and operatations in multiple kinds, as they have different meanings and means of reuse. 







"
Class {
	#name : #FylgjaAbstractRule,
	#superclass : #Object,
	#category : #'Fylgja-Rules'
}

{ #category : #'as yet unclassified' }
FylgjaAbstractRule class >> holdsPackageDocumentation [

	^ self = FylgjaAbstractRule
]

{ #category : #accessing }
FylgjaAbstractRule >> isAdaptingRule [

	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isDelegatingRule [
	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isFylgjaStub [

	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isInvocable [

	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isInvocation [

	^ false
]

{ #category : #accessing }
FylgjaAbstractRule >> isProductionRule [

	^ false
]

{ #category : #accessing }
FylgjaAbstractRule >> isRule [

	^ true
]

{ #category : #testing }
FylgjaAbstractRule >> isStatement [

	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isStatementExpression [

	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isTypeReference [
^ false
]

{ #category : #testing }
FylgjaAbstractRule >> isVariable [

	^ false
]

{ #category : #testing }
FylgjaAbstractRule >> priority [

	^ self subclassResponsibility
]
