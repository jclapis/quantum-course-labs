// Lab 3: Complex Superpositions
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Lab3 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;


    /// # Summary
    /// In this exercise, you are given a register of unknown length, which
    /// will be in the state |0...0>. Your goal is to put it into the |+...+>
    /// state, which is a uniform superposition of all possible states. For
    /// example, if it had three qubits, you would have to put it into this
    /// state:
    /// 
    ///     |+++> = 1/√8(|000> + |001> + |010> + |011>
    ///                + |100> + |101> + |110> + |111>)
    /// 
    /// # Input
    /// ## register
    /// A register of unknown length. All of its qubits are in the |0> state,
    /// so the register's state is |0...0>.
    /// 
    /// # Remarks
    /// This will test your knowledge of how to construct uniform
    /// superpositions, where a register is in a combination of all possible
    /// states, and each state has an equal amplitude to the others.
    operation Exercise1 (register : Qubit[]) : Unit {
        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are given a register with three qubits in it,
    /// and an extra "target" qubit. All of the qubits are in the |0> state.
    /// Your goal is to put the register into a uniform superposition of all
    /// possible states, and entangle the target qubit so that when all three
    /// register qubits are in the |1> state, the target qubit will be |1> as
    /// well. More specifically, you must generate this state:
    /// 
    ///     |register,target> = 1/√8(|000,0> + |001,0> + |010,0> + |011,0>
    ///                            + |100,0> + |101,0> + |110,0> + |111,1>)
    /// 
    /// # Input
    /// ## register
    /// A register of three qubits, in the |000> state.
    /// 
    /// ## target
    /// A qubit in the |0> state. It should be set to |1> when all of the
    /// register qubits are in the |1> state.
    /// 
    /// # Remarks
    /// This will show you how to use gates in controlled mode with more than
    /// one control qubit.
    operation Exercise2 (register : Qubit[], target: Qubit) : Unit {
        // Hint: You can call Exercise1() to achieve the first half of this
        // task. For the second half, look at the "MultiQubitGates" operation
        // in "QSharpReference.qs". It will show you the syntax for running a
        // gate in controlled mode with more than one control qubit.

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// This exercise is an extension of Exercise 2. Once again, you are given
    /// a register with three qubits in it, and an extra "target" qubit. All
    /// of the qubits are in the |0> state. Your goal this time is to put the
    /// register and the target qubit into this state:
    /// 
    ///     |register,target> = 1/√8(|000,0> + |001,1> + |010,0> + |011,0>
    ///                            + |100,0> + |101,0> + |110,0> + |111,0>)
    /// 
    /// Note that in this exercise, you must flip the target qubit when the
    /// register is in the |001> state instead of the |111> state.
    /// 
    /// # Input
    /// ## register
    /// A register of three qubits, in the |000> state.
    /// 
    /// ## target
    /// A qubit in the |0> state. It should be set to |1> when the register is
    /// in the |001> state.
    /// 
    /// # Remarks
    /// This will show you how to use zero-controlled (a.k.a. anti-controlled)
    /// gates.
    operation Exercise3 (register : Qubit[], target: Qubit) : Unit {
        // Hint: Q# doesn't have a "zero-controlled" concept built in; it only
        // triggers controlled gates when all of the control qubits are in the
        // |1> state. Find a way to convert the desired state, where some of
        // the qubits are in the |0> state, to the state |111> so the register
        // can be used as a set of control qubits.

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are given 3 separate three-qubit registers. Each
    /// of them will start in the |000> state.
    /// Your goal is to put them into the following uniform superpositions:
    /// 
    ///     |registers[0]> = 1/√8(|000> - |001> + |010> - |011>
    ///                         + |100> - |101> + |110> - |111>)
    ///     |registers[1]> = 1/√8(|000> + |001> - |010> - |011>
    ///                         + |100> + |101> - |110> - |111>)
    ///     |registers[2]> = 1/√8(|000> + |001> + |010> + |011>
    ///                         - |100> - |101> - |110> - |111>)
    /// 
    /// # Input
    /// ## registers
    /// An array of three 3-qubit registers, each of which is in the |000> state.
    /// 
    /// # Remarks
    /// This will show how phase flips affect complex superpositions with more
    /// than two states.
    operation Exercise4 (registers : Qubit[][]) : Unit {
        // Hint: For each register, look for something that all of the
        // negative states have in common, and use your knowledge of quantum
        // gates to take advantage of it. Try rewriting the superposition so
        // the positive states are on one side together, and the negative
        // states are on the other side together.

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are given a three-qubit register in the |000>
    /// state. Your goal is to put it in the following uniform superposition:
    /// 
    ///     |register> = 1/√8(|000> + |001> + |010> + |011>
    ///                     + |100> + |101> - |110> + |111>)
    /// 
    /// Note that all of the individual states are positive, except for |110>
    /// which is negative.
    /// 
    /// # Input
    /// ## register
    /// A register of three qubits, in the |000> state.
    /// 
    /// # Remarks
    /// This will teach you how to selectively flip the phase of specific
    /// states in a superposition by using an extra qubit.
    /// 
    /// This specific technique is called "phase kickback", and it's one of
    /// the most important techniques used in quantum algorithms; we'll talk
    /// about it more when we get to that section in class.
    operation Exercise5 (register : Qubit[]) : Unit {
        // Hint: This is somewhat like Exercise 3, where you flipped an extra
        // "target" bit once you found a certain state. This time, you will
        // need to allocate your own "target" qubit to flip when the register
        // is in the |110> state. Take a look at the "SingleQubitGates"
        // operation in the "QSharpReference.qs" to see how qubit allocation
        // is done. Don't forget to clean up the ancilla by setting it to |0>
        // before it goes out of scope!
        // 
        // Once you've allocated and flipped the target qubit, your goal is to
        // use that information to flip the phase of the |110> state.

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are given a register with two qubits in the |00>
    /// state. Your goal is to put it in this non-uniform superposition:
    /// 
    ///     |register> = 1/√2*|00> + 1/2(|10> + |11>)
    /// 
    /// Note: this state will have a 50% chance of being measured as |00>, a
    /// 25% chance of being measured as |10>, and a 25% chance of being
    /// measured as |11>.
    /// 
    /// # Input
    /// ## register
    /// A register with two qubits in the |00> state.
    /// 
    /// # Remarks
    /// This will show you that any gate can be used in controlled mode, not
    /// just the X gate.
    operation Exercise6 (register : Qubit[]) : Unit {
        // Hint: think about what happens to qubit 1 based on the state that
        // qubit 0 is in.
        // Tip: to create a new array with one element in it, wrap the element
        // in square brackets: 
        //      let newArray = [someQubit];

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are given a three-qubit register in the |000>
    /// state. Your goal is to transform it into this uneven superposition:
    /// 
    ///     |register> = 1/√2*|000> + 1/2(|111> - |100>)
    /// 
    /// # Input
    /// ## register
    /// A register with three qubits in the |000> state.
    /// 
    /// # Remarks
    /// This will combine everything you have learned so far into one problem:
    /// - Creating superpositions with the Hadamard gate
    /// - Quantum entanglement
    /// - Multi-controlled and zero-controlled gates
    /// - Phase-flipping specific states
    /// - Allocating qubits in Q#
    /// 
    /// Once you solve this, you've mastered the basics of quantum computing!
    operation Exercise7 (register : Qubit[]) : Unit {
        // Note: It is possible (but challenging) to prepare this state
        // without using an ancilla qubit.

        // TODO
        fail "Not implemented.";
    }



    //////////////////////////////////
    /// === CHALLENGE PROBLEMS === ///
    //////////////////////////////////


    // The following problems are challenge problems designed to test your
    // understanding and skills beyond the basics. These problems are
    // difficult and will require a firm understanding of quantum mechanics,
    // including the math behind quantum gates and register statevectors. You
    // do not need to solve these for the class, they are simply an optional
    // challenge you can use to test yourself.


    /// # Summary
    /// In this problem, you are given a two-qubit register in the |00> state.
    /// Your goal is to put it into this superposition:
    /// 
    ///     |register> = 1/√3(|00> + |01> + |10>)
    /// 
    /// Note that all three states have equal amplitude.
    /// 
    /// # Input
    /// ## register
    /// A two-qubit register in the |00> state.
    operation Challenge1 (register : Qubit[]) : Unit {
        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this problem, you are given a three-qubit register in the |000>
    /// state. Your goal is to put it into this superposition:
    /// 
    ///     |register> = 1/√3(|100> + |010> + |001>)
    /// 
    /// Note that all states have equal amplitude. This is known as the
    /// three-qubit "W State".
    /// 
    /// # Input
    /// ## register
    /// A three-qubit register in the |000> state.
    operation Challenge2 (register : Qubit[]) : Unit {
        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this problem, you are given a three-qubit register in the |000>
    /// state. Your goal is to encode 8 samples of a sine wave into its
    /// amplitude. The samples should be evenly spaced in π/4 increments,
    /// starting with 0 and ending with 7π/4. The sine wave samples are laid
    /// out in the table below:
    /// 
    ///  Index  |  Value
    /// ------- | -------
    ///    0    |    0
    ///    1    |   1/√2
    ///    2    |    1
    ///    3    |   1/√2
    ///    4    |    0
    ///    5    |  -1/√2
    ///    6    |   -1
    ///    7    |  -1/√2
    /// 
    /// Note that these samples are not normalized; if they were used as state
    /// amplitudes, they would result in a probability greater than 1.
    /// 
    /// Your first task is to normalize the sine wave samples so they can be
    /// used as state amplitudes. Your second task is to encode these 8
    /// normalized values as the amplitudes of the three-qubit register.
    /// 
    /// # Input
    /// ## register
    /// A three-qubit register in the |000> state.
    /// 
    /// # Remarks
    /// This kind of challenge is common in quantum computing - essentially,
    /// you need to construct an efficient circuit that will take real data,
    /// and encode it into the superposition of a qubit register. Note that
    /// normally, it would take 8 doubles to store these values in
    /// conventional memory - a total of 512 classical bits. You're going to
    /// encode the exact same data in 3 qubits. We'll talk more about how
    /// quantum computers do things faster than classical computers once we
    /// get to quantum algorithms, but this is a good first hint.
    operation Challenge3 (register : Qubit[]) : Unit {
        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// This problem is the same as Challenge 3, but now you must construct a
    /// superposition using 8 samples of a cosine wave instead of a sine wave.
    /// For your convenience, the cosine samples are listed in this table:
    /// 
    ///  Index  |  Value
    /// ------- | -------
    ///    0    |    1
    ///    1    |   1/√2
    ///    2    |    0
    ///    3    |  -1/√2
    ///    4    |   -1
    ///    5    |  -1/√2
    ///    6    |    0
    ///    7    |   1/√2
    /// 
    /// Once again, these values aren't normalized, so you will have to
    /// normalize them before using them as state amplitudes.
    /// 
    /// # Input
    /// ## register
    /// A three-qubit register in the |000> state.
    operation Challenge4 (register : Qubit[]) : Unit {
        // TODO
        fail "Not implemented.";
    }
}

