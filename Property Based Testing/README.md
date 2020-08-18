# Property Based Testing

## Properties
### Free Properties in Haskell
The language design and type system of Haskell ensures
- Memory is accessed where it is safe and permitted to be accessed (**memory safety**).
- Values of a certain static type will have that type at runtime. 
- Programs that are well typed will not lead to undefined behaviour. (**type safety**).
- All functions are **pure**: programs won't have side effects not declared in the type.

### Logical Properties and Functional Correctness
**Logical properties** are properties that pertain to the logic of our program.

The set of properties that capture all of our requirements for our program is called the **functional correctness specification** of our software.

This defines what it means for software to be **correct**.

It is often expressed as the combination of **data invariants** and a refinement from an abstract model.

## Testing
### Comparison To Proofs
Compared to proofs:
- Tests typically run the actual program and so makes fewer assumptions about the language semantics or operating environment.
- Test complexity does not grow with implementation complexity if the specifications are unchanged.
- Incorrect software when tested leads to immediate, debuggable counterexamples.
- Testing is typically cheaper and faster than proving.
- Tests care about efficiency and computability, unlike proofs.

Ultimately, testing trades **assurance** for **convenience ($$)**.

### Property Based Testing
The core idea behind **Property Based Testing** is to generate random input values, and test properties by running them.
**QuickCheck** is the Haskell library used for property based testing.

### PBT vs Unit Testing
Properties are more compact than unit tests and describe more cases resulting in **less testing code**.

However, property based tests depend heavily on **test data generation**:
- Random inputs may not be as informative as hand-crafted inputs:
  - use shrinking. This is the process of finding the smallest counterexample to a property.
- Random inputs may not cover all necessary corner cases:
  - use a coverage checker. These are tools that measure the quality of our tests.
- Random inputs must be generated for user-defined types:
  - QuickCheck includes functions to build custom generators.
  
### Redundant Properties
Some properties are technically redundant (implied by other properties) but there is still value to testing them:
- They may be more **efficient** than full functional correctness tests. 
- They may be more **fine-grained** to give better test coverage than random inputs for full functional correctness tests.
- The provide a good **sanity check** to the full functional correctness properties.
- Sometimes full functional correctness is **not easily computable** but tests of weaker properties are.

Redundant properties include **unit tests**, and we should combine the two.
 
## Coverage
**Coverage checkers** allow us to partially **quantify** the **quality** of our tests:
- Has all special cases been checked correctly?
- Has all code been exercised in the tests?
- Has all code been exercised in all contexts?

### Types of Coverage
|Type | Desciption | Example |
| --- | ---------- | ------- |
| Branch/Decision | Execution of all **conditional branches** | 
| Entry/Exit | Execution of all function **calls** | A function f is called in multiple places. We want to ensure all these **call locations are tested**. |
| Function | Execution of all **functions** |
| Statement/Expression | Execution of all **expressions** |
| Path | Execution of all **behaviours** (very hard) | We want to ensure all possible executions from the initial state is tested. |

### Haskell Program Coverage
**Haskell Program Coverage** is a GHC-bundled tool to measure function, branch and execution coverage.
