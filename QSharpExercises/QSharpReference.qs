// This file serves as a quick reference for the Q# language and a tutorial
// that shows you how to do some basic things with it. For the full API
// documentation, take a look at the Microsoft Developer Network page for Q#:
// https://docs.microsoft.com/en-us/qsharp/api/?view=qsharp-preview
// 
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

// In Q#, files are organized by namespaces. These are the same as namespaces
// in C#, and are analogous to packages in Java or sort of like modules in
// Python.
namespace QSharpExercises.QSharpReference {

    // ===========================================
    // =========== PART 1 - The Basics ===========
    // ===========================================



    // This is the syntax for referencing other namespaces in Q#. You can think
    // of this like a "using" statement in C#, or like an "import" statement in
    // Java or Python.
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;


    // Q#'s code structure is very simple. There are no classes and there are
    // no global variables; all you can define are "operations" and
    // "functions", which are essentially the equivalent of static methods.
    // The difference between an operation and a function is fairly subtle, so
    // for this course, we're just going to use operations for everything.


    /// # Summary
    /// This is an operation in Q#, which you can think of like a method for a
    /// classical program. It can take in arguments and return a value, just
    /// like a classical method would. This particular operation takes 4
    /// parameters. Note that Q# is a strongly-typed language, so the types of
    /// each parameter need to be explicitly defined in the operation
    /// signature.
    /// 
    /// # Input
    /// ## param1
    /// param1 is an Int type, which refers to a 64-bit signed integer. In C#
    /// and Java this would be called a "long", in Python it's basically just
    /// an int.
    /// 
    /// ## param2
    /// param2 is a tuple (an object with two elements in it). The first part
    /// is a Double, which is a 64-bit floating point number - essentially
    /// it's the same as the "double" type in C# and Java, and the "float"
    /// type in Python. The second element is just a typical string, like
    /// you'd use in any modern language. To get these two parts, you'll have
    /// to unpack the tuple in the operation's body.
    /// 
    /// ## param3 and param4
    /// The third and fourth parameters both belong to a tuple, like param2,
    /// but are decomposed directly into individual parameters in the
    /// operation signature. param3 is a Qubit, which is Q#'s type for qubits.
    /// Param4 is an array of qubits (also called a qubit register). Arrays in
    /// Q# work the same as arrays in C, C++, C# and Java: they have a fixed
    /// size and all of the elements in them must be the same type. This is
    /// different from Python lists, so if you're used to Python, keep that in
    /// mind.
    /// 
    /// # Output
    /// This function returns a "Result", which is a type that represents the
    /// result of a single qubit measurement. It only has two possible values:
    /// Zero and One.
    /// 
    /// # Remarks
    /// As you can see, Q# supports documentation comments (docstrings). They
    /// start with three slashes and use conventional Markdown syntax. Visual
    /// Studio will parse these and use them for Intellisense when you hover
    /// over operations. For example, hover over the name of this operation
    /// (OperationSyntax), and you'll see the summary text show up in a little
    /// tooltip along with the operation's signature. For more info on these,
    /// take a look at the "Comments" section of the official documentation:
    /// https://docs.microsoft.com/en-us/azure/quantum/user-guide/language/programstructure/comments?view=qsharp-preview
    operation OperationSyntax (
        param1 : Int,
        param2 : (Double, String),
        (param3 : Qubit, param4 : Qubit[])
    ) : Result {
        // Unpack the param2 tuple
        let (param2FirstElement, param2SecondElement) = param2;

        // Return a measurement result
        // (Zero in this case, which corresponds to the |0> state)
        return Zero; 
    }


    /// # Summary
    /// This operation shows how variable declaration and assignment works in
    /// Q#.
    /// 
    /// # Remarks
    /// For reference, Q# distinguishes between mutable and immutable
    /// variables. Any variable can be either one. Operation arguments are
    /// *always* immutable within the body of the operation.
    /// 
    /// Also note that the return function of this operation is "Unit". This
    /// is basically the same thing as "void" or "None" in most languages -
    /// it's the "nothing" type.
    operation VariableUsage () : Unit {
        // The "let" statement is used to declare new immutable variables.
        // Immutable variables are kind of like "readonly" variables in C# or
        // "final" variables in Java. You set the initial value in this
        // declaration statement, then the variable keeps that value forever. =
        // You're not allowed to change it.
        // 
        // Notice that the type of the variable doesn't have to be explicitly
        // stated; Q#'s compiler will figure out the type based on the
        // assignment. In this case, var1 is an Int.
        let var1 = 0;

        // The "mutable" statement is used to declare mutable variables, which
        // can be modified after their initial assignment with the "set"
        // statement.
        mutable var2 = "hello world";

        // This is an example of string interpolation, which was borrowed from
        // C#; strings that start with the $ symbol are interpolated, so you
        // can insert code inside them using the curly braces {} - the  code
        // inside them will get executed and the curly braces will be replaced
        // with the resulting string.  This is like the "f" string prefix in
        // Python.
        set var2 = $"var1 = {IntAsString(var1)}";
    }


    /// # Summary
    /// This shows some of the common types you'll run into in Q#. Note that
    /// it takes in some qubits as parameters, because we don't want to cover
    /// how they get allocated quite yet - that will come in a later
    /// operation.
    operation CommonTypes (inputQubit : Qubit, register : Qubit[]) : Unit {
        // Basic (primitive) types
        let anInt = 0;          // Int (64-bit integer)
        let aDouble = 0.0;      // Double (64-bit floating point)
        let aString = "string"; // String
        let aBool = false;      // Bool (boolean value; "true" or "false")
        let aUnit = ();         // Unit (like "void" in other languages)
        let aResult = One;      // Result (measurement result; Zero or One)

        // Tuples
        let tuple = (1, 2, 3.0);    // Tuple of an Int, Int, and Double
        let (e0, e1, e2) = tuple;   // Unpack tuple into individual elements
        let (e3, _, _) = tuple;     // Use underscores to ignore elements
        let nestedTuple = (         // Nested tuple
            1,
            (
                2.0,
                "3",
                (4.0, 5)
            )
        );

        // Ranges

        // This is a range, which represents a span of integers from 0 to 3
        // (inclusive), so 0, 1, 2, and finally 3. These are used for things
        // like for loops (which are discussed later). Note that ranges in Q#
        // are inclusive, so this will run from  0 to 3, not from 0 to 2!
        let range = 0 .. 3;

        // This range explicitly defines a step size of 2, so it will go like
        // this: 0, 2, 4, 6, 8, 10.
        let rangeWithStep = 0 .. 2 .. 10;

        // Range starting at 10, decrementing by 1 each iteration, and ending
        // at 1.
        let negativeRange = 10 .. -1 .. 1;

        // Arrays

        // Fixed-size array of 10 Ints - arrays should pretty much always be
        // mutable, otherwise you can't change their contents.
        mutable intArray = new Int[10];

        // The Length() function is used to get the length of arrays
        let arrayLength = Length(intArray);

        // Array addressing works like most other languages
        let array3 = intArray[3];

        // 2-dimensional array; you can go up to as many dimensions as you want
        mutable _2dArray = new Int[][4];

        // Appends the value "8" to the end of the array, increasing its
        // length by 1.
        set intArray += [8];

        // This is called an apply-and-replace operator, and it's essentially
        // how you modify arrays in Q# because they're actually immutable.
        // This particular example copies the array to a new array, except it
        // sets the element at index 3 of the new array to 22 in the process.
        // It's basically the same thing as "intArray[3] = 22;" but the Q#
        // team wants to enforce the point that arrays are immutable, and that
        // syntax implies you're directly changing an element of an array, so
        // they went with this weird syntax instead. The basic form is this:
        // set {array} w/= {index} <- {new value}
        set intArray w/= 3 <- 22;

        // This creates a new array that has the first 4 elements of intArray
        let subArray = intArray[0 .. 3];

        // Creates a new array that has elements 1, 3, 5, and 7 of intArray
        let subArray2 = intArray[1 .. 2 .. 7];

        // Creates a new array with the first and 10th elements of intArray
        let subArray3 = [
            intArray[0],
            intArray[9]
        ];

        // Callables (function objects)

        // This is an object that represents an operation. You can pass this
        // around like any other variable, and when you want, you can invoke
        // it (which will run the operation it represents).
        let method = OperationSyntax;

        // Run the operation
        let result1 = method(1, (2.0, "3"), (inputQubit, register));

        // This is a "partial operation", which is an object that represents
        // a method with some of the arguments specified, but not all of them.
        // The result with be a kind of "wrapper" operation that will take in
        // the missing arguments as its parameters. Hover over partialMethod
        // to see what its type is; it's an operation that takes an Int and a
        // (Qubit, Qubit[]) tuple, which are the two parameters that were
        // missing from the original operation's invocation.
        let partialMethod = method(_, (4.1, "five"), _);

        // Run the partial method by filling in the missing parameters, which
        // will then invoke the original operation with all of the arguments
        // (in this case, OperationSyntax).
        let result2 = partialMethod(6, (inputQubit, register));
    }


    /// # Summary
    /// Shows some of the common single qubit gates in Q# and how to use them.
    operation SingleQubitGates () : Unit {
        // Quantum gates in Q# are treated just like operations - they're
        // basically method calls, with the target qubit as the argument.

        // Allocate a single qubit. When you allocate a qubit with the "use"
        // statement, it is guaranteed to be in the |0> state. Once the use
        // statement goes out of scope, the qubit will be freed and available
        // for allocation somewhere else in the program. This is nice because
        // you don't need to keep track of all the qubits you've allocated;
        // you only need to care about the ones you're currently using, and
        // let the memory management system take care of allocation and
        // deallocation.
        use qubit = Qubit();

        I(qubit);   // Identity gate - does absolutely nothing
        X(qubit);   // X (NOT) gate - 180° rotation around the X axis
        Y(qubit);   // Y gate - 180° rotation around the Y axis
        Z(qubit);   // Z (phase-flip) gate - 180° rotation around the Z axis
        H(qubit);   // Hadamard gate - 180° rotation around the X+Z axis
        S(qubit);   // S gate - 90° rotation around the Z axis
        T(qubit);   // T gate - 45° rotation around the Z axis

        Rx(PI(), qubit);    // Rx gate - arbitrary rotation around the X axis
        Ry(PI(), qubit);    // Ry gate - arbitrary rotation around the Y axis
        Rz(PI(), qubit);    // Rz gate - arbitrary rotation around the Z axis,
                            // with a global phase applied

        // Rφ (phase-shift) gate - arbitrary rotation around the Z axis,
        // without a global phase (so it only affects the |1>  state).
        R1(3.0 * PI() / 4.0, qubit);

        // An alternative version of the Rφ gate which is useful if the angle
        // φ is of the form φ = (π*k / 2^n). The first parameter is k, the
        // second is n.
        R1Frac(3, 5, qubit);

        // Measurement gate/operation - measures a qubit, either resulting in
        // Zero (|0>) or One (|1>).
        let measurement = M(qubit);

        // Qubits allocated with the use statement need to be put back in the
        // |0> state before the statement goes out of scope and they get
        // deallocated. The Reset() function is an easy way to do this.
        Reset(qubit);
    }


    /// # Summary
    /// Shows some of the control flow statements you can use in Q#.
    operation ControlFlow () : Unit {
        mutable intArray = new Int[10];
        let length = Length(intArray);
        let result = One;
        let isResultZero = (result == Zero);
        let someOtherBool = true;
        
        // For loop that goes through a range. Similar to the C-style for loop
        // used in other languages, like "for(int i = 0; i < length; i++)".
        // Note that the range used here is inclusive; the last term will be
        // included in the indices so if you're iterating over an array, you
        // have to set it to length - 1.
        for i in 0 .. length - 1 {
            set intArray w/= i <- i;    // intArray[i] = i;
        }

        // For loop that enumerates all of the elements in the array; this is
        // the same as "for each" in other languages.
        for i in intArray {
            // Do something with i
        }


        // This is a repeat-until loop, which is sort of like a "do-while"
        // loop used in other languages. It executes the body of the "repeat"
        // statement until the condition in the "until" statement is true. For
        // each iteration, if it isn't true, then it runs the  body of the
        // "fixup" statement.
        mutable someNumber = 0;
        repeat {
            set someNumber += 1;
        }
        until someNumber == 10
        fixup {
            // Message() lets you write strings back to the classical driver
            // code. This is like Console.WriteLine() or system.out.println()
            // or print() or whatever the equivalent of an output function is
            // in your favorite language.
            Message($"Number is {someNumber}/10.");
        }


        // If statements
        if isResultZero {
            // The "fail" statement is basically used to throw an exception
            // with a message attached to it. You can do string interpolation
            // here with a $ at the beginning of the string to make your
            // exception messages more useful.
            fail "Oh no, we measured |0> instead of |1>! Disaster!";
        }
        elif someOtherBool  {   // The same as "else if" in other languages
            Message("We measured a |1>, yay!");
        }
        else {
            // You can put return statements anywhere in your code, and they
            // behave just like return statements in every other language. In
            // this case, because the function has a Unit return type (which
            // is basically just "void" / "NoneType"), we just return the
            // empty tuple with is kind of like "null" or "None".
            return ();
        }


        // This is the ternary conditional operator. It takes the form:
        // {condition} ? {result if true} | {result if false}
        // This is like a one-line version of an "if-else" statement.
        let resultAsInt = result == One ? 1 | 0;
    }


    /// # Summary
    /// Shows some of the multi-qubit gates in Q#, and how to run gates and
    /// operations that are controlled on multiple qubits.
    operation MultiQubitGates () : Unit {
        use qubits = Qubit[10]; // Allocate 10 qubits

        // Applies the SWAP gate, which switches the states between the 2
        // qubits. If q0 = a|0> + b|1> and q1 = c|0> + d|1>, then after the
        // gate, q0 will be c|0> + d|1> and q1 will be a|0> + b|1>.
        SWAP(qubits[0], qubits[1]);

        // Applies the controlled X (NOT) gate, which will apply X to the 2nd
        // argument only when the first argument is in the |1> state. In other
        // words, it turns the state (a|00> + b|10>) into the state
        // (a|00> + b|11>). This is called an "entangling gate" because it's
        // the most common way to entangle 2 qubits together.
        CNOT(qubits[2], qubits[3]);

        // Applies the double-controlled X (NOT) gate, also called CCNOT or
        // the Toffoli gate. Same idea as above: if the first two arguments
        // are in the |1> state,  it will apply X to the third argument.
        CCNOT(qubits[4], qubits[5], qubits[6]);

        // This is a generic multicontrolled version of the X gate. What this
        // says is if all of the qubits in the first argument are |1>, then it
        // will apply X to the 2nd argument. In this case, if the first 9
        // qubits in the register are |1>, then it will flip the 10th qubit.
        Controlled X(qubits[0 .. 8], qubits[9]);

        // In Q#, any operation that supports the "controlled" keyword can be
        // run with an arbitrary number of control qubits on it. This is the
        // same as the previous gate, but instead of flipping the last qubit,
        // it will apply the Hadamard gate to it.
        Controlled H(qubits[0..8], qubits[9]);

        // Don't forget to reset all the qubits to the |0> state when you're
        // done with them!
        ResetAll(qubits);
    }



    // ===============================================
    // =========== PART 2 - Advanced Stuff ===========
    // ===============================================



    /// # Summary
    /// This shows how to create an operation that can be run in Adjoint mode
    /// (run backwards) or in Controlled mode (run with control qubits).
    /// See the "Operation Characteristics" section of the "Operations and
    /// Functions" doc for more info:
    /// https://docs.microsoft.com/en-us/azure/quantum/user-guide/language/typesystem/operationsandfunctions#operation-characteristics
    operation Functors1 (target : Qubit) : Unit is Adj + Ctl {
        // If all contained operations support the Adjoint and Controlled
        // functors, then you can simply put "is Adj + Ctl" in the declaration
        H(target);
        S(target);
        T(target);
    }

    /// # Summary
    /// This is equivalent to Functors1, but with the specializations declared
    /// using auto-generation directives. See this Q# Enhancement Proposal
    /// (QEP) for more info:
    /// https://github.com/microsoft/qsharp-language/blob/main/Implemented/partial-specialization-inference.md
    operation Functors2 (target : Qubit) : Unit {
        body (...) { // You have to wrap all your code with this statement
            // Normal code goes here
            H(target);
            S(target);
            T(target);
        }

        // After the body, put the "adjoint" keyword to specify what should
        // happen when the operation is invoked with the Adjoint functor.
        // There are 2 auto-generation directives for adjoint:
        //
        //      "adjoint self" means the operation is exactly the same
        //          forwards as it is backwards, so the operation is its own
        //          adjoint. The compiler will just run the function as-is
        //          when someone calls it in Adjoint mode.
        //
        //      "adjoint invert" means the operation should be inverted when
        //          run in Adjoint mode. All of the quantum operations will be
        //          run in reverse order, and all of the gates will be
        //          replaced by their Adjoint versions.
        // 
        // You can also use "adjoint auto" to have the compiler automatically
        // pick which auto-generation directive to use.
        adjoint invert;

        // Similarly, the "controlled" keyword allows you to specify what
        // should happen when the operation is invoked with the Controlled
        // functor. There is just 1 auto-generation directive for controlled:
        //
        //      "controlled distribute" means that, when run in Controlled
        //          mode, each contained gate or operation will be run in
        //          Controlled mode as well with the control qubits passed to
        //          the functor.
        //
        // "controlled auto" also works here.
        controlled distribute;

        // In situations where it is necessary to support Controlled Adjoint
        // mode, use "controlled adjoint". This one gets a little tricky; here
        // are the different auto-generation directives:
        //
        //      "controlled adjoint self" means to use the controlled
        //          specifiction as-is in Controlled Adjoint mode.
        //
        //      "controlled adjoint invert" means to generate the functor
        //          based on the controlled specification but with the order
        //          reversed and everything in Adjoint mode.
        //
        //      "controlled adjoint distribute" means to generate the functor
        //          based on the adjoint specification but with everything in
        //          Controlled mode.
        //
        // Again, "controlled adjoint auto" works.
        controlled adjoint invert;
    }

    /// # Summary
    /// This is equivalent to Functors1 and Functors2, but with the
    /// specializations explicitly defined. Note that it is possible to mix
    /// explicit specialization declarations and auto-generation directives
    /// (not shown here). See the "Specialization Declarations" section of the
    /// docs for more info:
    /// https://docs.microsoft.com/en-us/azure/quantum/user-guide/language/programstructure/specializationdeclarations
    operation Functors3 (target: Qubit) : Unit {
        body (...) {
            H(target);
            S(target);
            T(target);
        }

        adjoint (...) {
            Adjoint T(target);
            Adjoint S(target);
            Adjoint H(target);
        }

        controlled (controls, ...) {
            Controlled H(controls, target);
            Controlled S(controls, target);
            Controlled T(controls, target);
        }

        controlled adjoint (controls, ...) {
            Controlled T(controls, target);
            Controlled S(controls, target);
            Controlled H(controls, target);
        }
    }

    /// # Summary
    /// This shows you how to run operations in Adjoint or Controlled mode.
    operation FunctorCalls () : Unit {
        use (controls, target) = (Qubit[1], Qubit());
        Functors1(target);
        Adjoint Functors1(target);
        Controlled Functors1(controls, target);
        Controlled Adjoint Functors1(controls, target);
    }
}
