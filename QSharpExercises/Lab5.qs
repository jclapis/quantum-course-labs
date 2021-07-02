// Lab 5: Deutsch-Jozsa Algorithm
// Copyright 2021 The MITRE Corporation. All Rights Reserved.

namespace QSharpExercises.Lab5 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;


    /// # Summary
    /// This oracle always "returns" zero, so it never phase-flips the output
    /// qubit.
    /// 
    /// # Input
    /// ## input
    /// The input register to evaluate
    /// 
    /// ## output
    /// The output (result) qubit to flip
    operation AlwaysZero (input : Qubit[], output : Qubit) : Unit {
        // This literally does nothing, no matter what the input is.
    }


    /// # Summary
    /// This oracle always "returns" one, so it always phase-flips the output
    /// qubit.
    /// 
    /// # Input
    /// ## input
    /// The input register to evaluate
    /// 
    /// ## output
    /// The output (result) qubit to flip
    operation AlwaysOne (input : Qubit[], output : Qubit) : Unit {
        // All this does is phase-flip the output. The input is useless here.
        Z(output);
    }


    /// # Summary
    /// In this exercise, you are given a register with an unknown number of
    /// qubits, in an unknown state, and an output qubit in the |1> state.
    /// Your goal is to construct an oracle that will flip the phase of the
    /// output qubit if the register contains an odd number of qubits in the
    /// |1> state, and leave the output qubit alone if the register contains
    /// an even number of qubits in the |1> state.
    /// 
    /// For example, if the register was in the state |10101>, you would
    /// phase-flip the output qubit because there was an odd number of |1>
    /// qubits. If the register was in the state |01010>, you would leave the
    /// output qubit alone.
    /// 
    /// # Input
    /// ## input
    /// A register of qubits in an unknown state. It could be in an arbitrary
    /// superposition.
    /// 
    /// ## output
    /// An output qubit that you must flip if the oracle's conditions are met.
    /// It will be in the |1> state to start; you must put it in the -|1>
    /// state if the register has an odd number of qubits in the |1> state.
    operation Exercise1 (input : Qubit[], output : Qubit) : Unit {
        // Note: Oracles aren't allowed to collapse the superposition of the
        // input register, so you aren't allowed to do any qubit measurements.
        // You'll need to use some kind of controlled gate that will give the
        // correct result, no matter what the input is.
        // 
        // Hint: If you phase-flip the output qubit twice, it will have the
        // same effect as not flipping it at all. Phase-flipping it three
        // times will have the same effect as only flipping it once, etc.
        
        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you are given a register with an unknown number of
    /// qubits, in an unknown state, and an output qubit in the |1> state. You
    /// are also given two indices of qubits in the register. Your goal is to
    /// construct an oracle that will phase-flip the output qubit if the two
    /// qubits with the given indices have different parity; that is, if both
    /// qubits are in the same state, you should leave the output qubit alone.
    /// If the qubits are in opposite states, you should phase-flip the
    /// output.
    /// 
    /// # Input
    /// ## firstIndex
    /// The index in the register of the first qubit to use in the parity
    /// check.
    /// 
    /// ## secondIndex
    /// The index in the register of the second qubit to use in the parity
    /// check.
    ///
    /// ## input
    /// A register of qubits in an unknown state. It could be in an arbitrary
    /// superposition.
    /// 
    /// ## output
    /// An output qubit that you must flip if the oracle's conditions are met.
    /// It will be in the |1> state to start; you must put it in the -|1>
    /// state if the two qubits in the register at the given indices have
    /// opposite parity.
    operation Exercise2 (
        firstIndex : Int,
        secondIndex : Int,
        input : Qubit[],
        output : Qubit
    ) : Unit {
        // Note: you cannot use the same technique that you used in Lab 4 for
        // parity measurement, because the input qubits may not be entangled.
        // Ancilla measurement based parity checks only work if the qubits
        // have been encoded in a specific way, and these may not have been.
        // You'll have to find a way to check the parity of the two qubits
        // without measuring anything.

        // TODO
        fail "Not implemented.";
    }


    /// # Summary
    /// In this exercise, you will implement the Deutsch-Jozsa algorithm. You
    /// are given an oracle, which is an operation that takes in a qubit
    /// register and an output qubit that will be phase-flipped if the
    /// register meets the oracle's condition. The register must be in the
    /// |+...+> state, and the output qubit must be in the |1> state. Your
    /// goal is to prepare the input register and output qubit, run the oracle,
    /// and use the resulting state of the register to determine whether the
    /// oracle represents a constant function or a balanced function.
    /// 
    /// # Input
    /// ## inputLength
    /// The number of qubits that the oracle expects the input register to
    /// contain. You must allocate a register with this many qubits to provide
    /// to the oracle.
    /// 
    /// ## oracle
    /// An operation that represents some quantum function. It will take in an
    /// input register (that must be in the |+...+> state) and an output qubit
    /// (that must be in the |1> state). It will phase-flip the output qubit
    /// for each state in the register's superposition that meets its
    /// criteria, causing that state to become phase-flipped as well.
    /// 
    /// # Output
    /// You should return true if the function is constant, or false if it is
    /// balanced.
    operation Exercise3 (
        inputLength : Int,
        oracle : ((Qubit[], Qubit) => Unit)
    ) : Bool {
        // Tip: you can allocate multiple different things at once using tuple
        // notation. For example: 
        //      use (input, output) = (Qubit[inputLength], Qubit())
        // will allocate a qubit register called "input", and a single qubit
        // called "output".
        // 
        // Note: Remember to put the input and output in the correct states
        // before running the oracle!

        // TODO
        fail "Not implemented.";
    }
}
