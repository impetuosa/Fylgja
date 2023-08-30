# Fylgja - Mappings

Mappings are evidence of semantic equivalence. By semantic equivalence we mean that a source entity is equivalent to a target entity. A mapping can be the outcome of the user manually configuring the engine. It can also be the engine’s outcome establishing a relationship between two entities. 
We distinguish two kinds of mappings: Simple and nested.
- Simple mapping relates a source declaration with a target declaration. 	It works as a simple association, implying that the source declaration is equivalent to the target declaration in the target ASG. This mapping is enough to map two entities without parameters or two target entity that was produced based on the source entity (assuming that if there are parameters, they did not change order).  eg (Void => void); (String => String); etc. 
- Nested mapping associates a source declaration with a target declaration and the parameters between source and target declarations. This mapping also specifies if a parameter on the source declaration becomes a receiver in the target. eg let's consider the mapping between function F(x,y,z) and method M(a,b,c). 
Three  mappings examples could be: 
**(F => M (a => z; b => y; c => x))**: all the target parameters are mapped to all source parameters. The order changes.
**(F=>M(a=>x;b=>y;c=>x))**: parameters a and c are mapped to x; parameter b is mapped to a. Parameter z is dismissed.
**(F=>M(a=>x;b=>y;c=>x;z=>R))**: parameters a and c are mapped to x; parameter b is mapped to a. Parameter z is proposed as a receiver.


## FylgjaMapping
### Properties
source
target

### Methods
#### FylgjaMapping>>source: anObject 
It sets the source of the mapping. For the association (Source => Target), we are setting Source. 

#### FylgjaMapping>>target: anObject
It sets the target of the mapping. For the association (Source => Target), we are setting Target. 

#### FylgjaMapping>>mapsSource: aMOLocalVariable
Tests if this mapping is using something like the parameter as source (Source => Target).



## FylgjaMappingInstaller
Given mapping configuration I creates the proper objects and install them in a given context.

### Properties
context
installAtTopLevel
installAtLanguageLevel
source
target
mapping

### Methods
#### FylgjaMappingInstaller>>map: aProvenanceEntity with: aDestinationEntity using: aMappingCollection
Configure the entities to be mapped. Source, Target, Parameter mappings 

#### FylgjaMappingInstaller>>installInto: aFylgjaDerivativeModel
Build and install mapping into a given Fylgja model



## FylgjaNestedMapping
NestedMapping class.

### Properties
source
target
mappings

### Methods
#### FylgjaNestedMapping>>mappings: anObject
Sets the nested mappings. The parameter is expected to be a collection of simple mappings. 

#### FylgjaNestedMapping>>choose: aMOParameter from: aCollection
Given a parameter and a collection, It returns the object of a collection that should be mapped to the given parameter. 

#### FylgjaNestedMapping>>map: aCollection
Given a collection of arguments, returns a mapped collection them according to the parameter mapping 

#### FylgjaNestedMapping>>isEquivalentTo: aFylgjaNestedMapping
It tests if this nested mapping is equivalent to an other mapping. It avoid the redefinition of = to avoid the redefinition of hash.



## FylgjaSimpleMapping
SimpleMapping class.

### Properties
source
target
engineSet

### Methods
#### FylgjaSimpleMapping>>isSetByEngine
Tests if the mapping is made or not automatically by the engine

#### FylgjaSimpleMapping>>setAsEngine
Sets the mapping to trace down the fact that it is a generated mapping, and not user made. 

#### FylgjaSimpleMapping>>map: aCollection
Given a collection of arguments, returns a mapped collection them according to the parameter mapping. In the case of SimpleMapping, it returns the same collection of arguments. 



