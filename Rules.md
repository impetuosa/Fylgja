# Fylgja - Rules

Rules are scoped conditional operations consisting of a Condition and an Oper- ation. Condition consists of a predicate that ensures the satisfaction of the operation’s assumptions and requirements. Operation consists of any system- atic modification over the target. By scoped, we mean that they have a scope of validity. This scope is all migration models, as there are default rules, a spe- cific project, package, class, or method. This context is defined when installing the rules. We have two families or rules: Productive and Adaptive.

## Productive
These rules create a migrated version of a source entity in the context of a target entity, that is to say, as a child of this target entity. Applying a Productive Rule also entails automatically mapping the source entity and the produced target entity.
* Condition consists of a predicate that tells if the rule can produce this migrated version within the specific target entity.
* Operation consists of modifying the target entity by defining the source entity’s migrated version. These rules are typically applied from the legacy application model containing the source entity to a migrated application model containing the target entity.
For example, a rule that is executed when the source entity is a function and the target context is a class, and it operates a migration by defining a method in the target class based on the source function.


## Adaptive 
We said before that references to a software artefact must be replaced as ref- erences to another equivalent software artefact. To enable this replacement mechanism, we copy the references as they are, knowing that this may be a wrong decision, and delay the migration criteria to when this other soft- ware artefact is available. Adaptive rules detect the apparition of semantically equivalent declarations and modify or replace reference objects based on the nature of the software artefact.
* Condition consists of a predicate that tells if the rule can modify or replace a target reference to refer to a given target declaration.
* Operation consists of the adaptation of the reference object.
For example, let us consider a function that just migrated as a static method. Right after, an adaptive rule will detect that this static method is recognised as equivalent to the function and therefore detect all the uses (migrated before and after the migration of the function) and adapt them from the form function() to the form ClassName.function().

## Implementation
In the implementation we hold two kind of rules: Static and Dynamic. 
Static rules define condition and operation as methods.
Dynamic rules define condition and operation as strategies. 
Static rules are easier to read, however, the condition and transformations to be applied become impossible to reuse. 
Dynamic rules are harder to read and to construct. 

## Kind of rules 
We split the productive rules and operatations in multiple kinds, as they have different meanings and means of reuse. 

## Operations
Operations are reification of transformations to be applied. 
Often operation objects are used as an operative part of a dynamic rule, however, they can be arbitrarily used by other operations.
An example of this is FylgjaCopy, which copies the definition of a source element into a given target contextual element. 
From this hierarchy 

### Translation operations
These operations are of the translation kind. All of them inherit from the FylgjaProduction class.
Translations have a fine granularity of transformation and they act over language elements. 
The translation proposed in this hierarchy are of the kind of producing equivalent semantic elements such as translating a On Error Go To from access to Try Catch in java or typescript. 
As this operations are based on language concepts, they can be reuse over different technologies in some cases.
Operations such as operator replacement (to transform a & b to a + b) can be reused across many languages. 
Operations such as On Error Go To from access to Try Catch, can be used to many target technologies (all those using try catch) but only appliable over Microsoft Access code, as the statement on error go to it is only existing in VB.  

### Modification operations
These operations are of the transofrmation kind. All of them inherit from the FylgjaModification class.
The transformations proposed in this hierarchy are of the kind of producing specific bricks of code such as: AddAttribute, AddGetter / AddSetter etc. 

### Generation operations 
are those operations which generate large pieces of code based on certain description or source entity. 
 This kind of rules are often strict for source and target technology. 
 For example, how to create a hibernate/spring DAO class, a controller, a model or a service based on analyzing the configuration of a Microsoft Access form.
 






