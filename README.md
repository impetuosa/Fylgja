# Fylgja - ReadMe
## Manifest
Fylgja is an engine for model transformation. 
The engine is specialized on software migration.
This engine has been presented in [Context Aware Partial Translation engine based on immediate and delayed Rule application](https://hal.inria.fr/hal-03898154v1) and [Interactive, Iterative, Tooled, Rule-Based Migration of Microsoft Access to Web Technologies](https://hal.inria.fr/hal-04181591v1).
The fylgja engine is built on top of the Moxing model ([https://github.com/impetuosa/Moxing/](https://github.com/impetuosa/Moxing/)) which implements several importers, allowing to using the same model to represent projects written in Microsoft Access, Java, Angular+Typescript etc. 
The following figure overlooks the architecture, and points the different URLs to visit in order to get more insight. 
![https://github.com/impetuosa/Fylgja/blob/master/resources/fylgja-arch.jpg?raw=true](https://github.com/impetuosa/Fylgja/blob/master/resources/fylgja-arch.jpg?raw=true)

## Language Migration
Migrating an application from a source language to a target language implies we must produce a new application with the same semantics as the original application but in a different language/technology, i.e., using the target envi- ronment: native types and primitives, SDK, and libraries: all of which make this environment a desirable target. Such migrations are challenging because different languages propose different concepts, some unique to the language e.g., Java generics, MS Access error management or Pharo thisContext. However, programming languages also present overlaps in common concepts such as functions, methods, and classes. To migrate language means at least replacing
the source language concepts with those of the target language able to achieve similar behaviour.
## A language migration example
Let us consider the code in Listing 1. A Visual Basic Application module used for testing named Testing, with a function testing the function Len using HelloString global variable as a parameter. This global is defined in another module named ProjectGlobals.
```vba
Public Function testLen() : Void
  Call Assert(Len(HelloString), 5, "Should be 5")
End Function
```
Let us consider the translation of our example to Java using JUnit3. We could propose to achieve these by applying the following translations:
1 Translate the module as a class subclass of TestCase.
2 Translate the function as a method.
3 Translate the return type Void as void.
4 Translate the call to Assert(x,y,z) as "this.assertEquals(z,x,y)"
5 Translate the access to the global HelloString as [ParentName].[GlobalName]. 6 Translate the call to Len(x) as x.length().
In Listing 2, we find the version translated into Java language, along with the number of proposed transformations used to generate each line.
```java
(1) class TestingModule extends TestCase {
(2)	void 
(3)	testLen () {
(4)		this.assertEquals("Should be 5", 
(5)			ProjectGlobals.HelloString
(6)			.length(),
			 5);
	}		
}
```
However, there are three main restrictions to this approach: By having rules that express how to write expressions such as [ParentName].[GlobalName], we make an assumption that imposes strict constraints over what, how and when something is going to be translated.

## **What**, **how** and **when** to translate
Language migration is a complex and risky endeavour. To think of migration as a single task is unacceptable. 
We aim to enable a language migration that first produces the most needed features. 
This is why we care about being able to define what, how and when to translate.

- What to translate. Much of our code may not be needed in the target or be replaced by a target library, a service, etc. When translating our example, questions about what to translate arise: Do we need to translate ProjectGlobals? Should we want to translate the global HelloString?
- How to translate. An artefact in a source language may have one or many possible representations in a target lan- guage. When translating our example, questions about how to translate arise: Is it HelloString going to be translated as a static public variable? Should we add any accessor? The decision will impact not only this single artefact but the translation of all the uses of this artefact.
- When to translate. To produce an application that we can deliver to accomplish its task, we need to have a functional target application. We do not want to wait to fully finish the translation to start some features of the target application. Therefore, we have to be able to define what to translate first. 	When translating our example questions about when to translate arise: Should we translate the full ProjectGlobals module before being able to translate and execute this test? 

## Parts of a language migration engine
- Application meta-model
For modelling, we use Heterogeneous Unified Meta-Model as described by CITE ICPC. Our specific implemen- tation is an Abstract Semantic Graph (ASG).
Our ASG is made up of Declarations, Statements and Expressions. Declarations define structural and identifiable artefacts of some specific nature: types, functions, etc. Statements define actions to be carried out. Expressions define actions to be carried out and yield a value.
Declarations are defined in terms of other declarations. e.g., Classes are declared referring to their superclasses. We call those elements used to relate an entity with a declaration References.
The meta-model is heterogeneous because it reuses concepts and defines concepts specifics per language. Any language using control flow statements may use the classes If, While and For. On the other hand, On-Error-Go-To is likely to be used only by MS Access models.
- Source and target application models
Our proposal is based on the modelling of source and target applications as two independent models. Both are represented using the same meta-model.
Figure 1 is a graphical representation of an ASG instance which represents the source code listed in Listing 1. The function declaration node has an arrow pointing to a type-reference object, with a dotted line arrow pointing to the type Void.

- Mapping
Mappings are evidence of semantic equivalence. By semantic equivalence we mean that a source entity is equivalent to a target entity. A mapping can be the outcome of the user manually configuring the engine, as explained in Section 5.3. It can also be the engine’s outcome establishing a relationship between two entities as explained in Section 4.5. We distinguish two kinds of mappings: Simple and nested.
1 Simple mapping relates a source declaration with a target declaration. 	It works as a simple association, implying that the source declaration is equivalent to the target declaration in the target ASG. This mapping is enough to map two entities without parameters or two target entity that was produced based on the source entity (assuming that if there are parameters, they did not change order).  eg (Void => void); (String => String); etc. 
2 Nested mapping associates a source declaration with a target declaration and the parameters between source and target declarations. This mapping also specifies if a parameter on the source declaration becomes a receiver in the target. eg let's consider the mapping between function F(x,y,z) and method M(a,b,c). Three  mappings examples could be: 
(F => M (a => z; b => y; c => x)): all the target parameters are mapped to all source parameters. The order changes.
(F=>M(a=>x;b=>y;c=>x)): parameters a and c are mapped to x; parameter b is mapped to a. Parameter z is dismissed.
(F=>M(a=>x;b=>y;c=>x;z=>R)): parameters a and c are mapped to x; parameter b is mapped to a. Parameter z is proposed as a receiver.
- Rules
Rules consist of a Condition and an Operation. Condition consists of a predicate that allows the user to define specific requirements for the operation to be applied. Operation consists of any systematic modification over the target. A rule returns a single entity. Each time the engine creates a target declaration out of applying a rule over a source declaration, it produces a simple mapping between these artefacts as explained in Section 5.3.
**Translative rules**
These rules are immediately applied when the user requires to translate a source entity within a target context. These rules produce, as a result, a single target entity.
**Adaptive rules**
Rules to be applied during Adaptive phase (Section 4.7): after the execution of translative rules and the installation of linked stubs. An adaptive rule automates the translation of any reference object based on how the referred object has been translated or mapped. There is an implicit dependency between the nature of a declared artefact and the kind of reference able to interpellate it. To activate a function which receives one parameter, we use a function invocation with one argument. Adaptive rules are based on this dependency.
## Load
```smalltalk
loadMetacello
	  Metacello new
    	githubUser: 'Impetuosa' project: 'Fylgja' commitish: 'v1.x.x' path: 'src';
    	baseline: 'Fylgja';
    	onWarningLog;
    	load
	
```
```smalltalk
loadAddBaseline
	| spec |
	spec
		baseline: 'Fylgja'
		with: [ spec repository: 'github://impetuosa/Fylgja:v1.x.x/src' ]
```

## Project Examples


```smalltalk
exampleCreateFylgjaEngine
	| fylgja |
	" 
	A Fylgja migration engine works over Moxing models. So, before we start to work with any engine, we need at least two models which are going to be used to exchange content.
	
	1- Create Moxing models.
	Please, to learn how to create your own Moxing model, address the Moxing documentation.  
	"
	
	
	northwind := MoxingManifest accessNorthwind.
	angular := MoxingManifest angularNorthwind.
	java := MoxingManifest javaNorthwind.
	
	"
	
	2- Create a FylgjaMigrationEngine instance. 
	
	"
	fylgja := FylgjaMigrationEngine new.
	
		"
	
	3- Add the moxing models one by one. Please note that the order is not important, and that there is not limit of models. 
	Fylgja engine will orchestrate and enable the different exchnages between the given models. 
	
	"
	fylgja
		addModel: northwind;
		addModel: angular;
		addModel: java.
	^ fylgja
```

```smalltalk
exampleConfigureFylgjaRules
	| fylgja |
	" 
	In this example we check how to install rules. 
	
	
	1- We create an engine, as described in exampleCreateFylgjaEngine.
	
	"
	fylgja := self exampleCreateFylgjaEngine.
	"
	2- Rules can be installed with the help of a rule installer as a DSL. 
	The next snippet of code installs a rule which tells: when ever translating a binary operator & to java, it should be translated as binary operator +.
	
	"
	FylgjaRuleInstaller new
		context: java root;
		binaryOperator: #&;
		replaceOperatorWith: #+;
		installInto: fylgja.
	"
	3- Rules can be installed with the help of a rule installer, and giving a rule instance to be installed.
	The  FylgjaSimpleRenameRule is a rule which renames any element according to the target. 
	Please address to the article: ``Context Aware Partial Translation engine based on immediate and delayed Rule application`` to find a catalog of explained rules.  
	
	"
	
	FylgjaRuleInstaller new
		context: java root;
		install: FylgjaSimpleRenameRule new into: fylgja.
	
	"
		The user can add rules at will at any moment of the usage of the engine. 
	
	"
	^ fylgja
```

```smalltalk
exampleConfigureNorthwindFylgjaRules
	| fylgja |
	" 
	In this example we check how to install rules for the case of migrating MS Access projects to AngularTs and Java. 
	
	
	1- We create an engine, as described in exampleCreateFylgjaEngine.
	
	"
	fylgja := self exampleCreateFylgjaEngine.
	"
	2- To install the different rules required for this project, we provided some installing objects. 
	#ruleInstallers returns instances of different classes able to intall different rules. 
	This instances require to be configured in a way that they can diffentiate what is access, java and angular. 
	Please browse the FylgjaNorthwindRuleInstaller class for more details.
	"
	FylgjaMigrationUIController ruleInstallers do: [ :installer | 
		installer
			fylgja: fylgja;
			northwind: northwind;
			java: java;
			angular: angular;
			installRules ].
	"
		The user can add rules at will at any moment of the usage of the engine. 
	
	"
	^ fylgja
```


exampleOpenFylgjaUINorthwind
	| fylgja controller |
	" 
	In this example open the Fylgja UI IDE for Northwind project. 
	
	
	1- We create an engine, as described in exampleCreateFylgjaEngine and configure it as exampleConfigureNorthwindFylgjaRules.
	
	"
	fylgja := self exampleConfigureNorthwindFylgjaRules.
	"
	
	2- We are going to avoid working on the models directly from the very begining to be able to restart without having to reload the models. 
	For doing so, we will give to our UI controller a derivative of our engine. 
	For learning more about derivative models, please browse FylgjaDerivativeModel and MOModelDerivative classes. 
	
	"
	fylgja := fylgja derivative
		          installAllDerivativeModels;
		          yourself.
	"
	3- the migrating session is managed by a UI controller: FylgjaMigrationUIController. 
	This controller will communicate the different widgets and decide what to do when user helps is required. 
	You probably want to save the controller reference. 
	"
	controller := FylgjaMigrationUIController new
		              fylgja: fylgja;
		              origin: northwind;
		              destinations: { 
				              java.
				              angular };
		              yourself.
	"
	4- The controller can open arbitrary number of UI which are controlled by the same controller and acting over the same models.
	For opening a UI, just send the message #openMigrator.
	
	"
	controller openMigrator.
	^ controller
```


